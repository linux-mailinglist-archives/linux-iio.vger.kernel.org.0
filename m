Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD9252684
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 07:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgHZFUx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 01:20:53 -0400
Received: from www381.your-server.de ([78.46.137.84]:44152 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHZFUv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 01:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=CyQVAtKumH91Szy/RIZgeJQhpiAa+j3QqIry2t0RtpU=; b=JoGAHWZOeoyuwZqUqxPoChV9Nb
        XlcIDLgzdKxP8jUqXUmVd0LXz52UUsZnz47oBS+X3wFA1dKqauakMp19LHQN27O41xcNaFBRM4v1H
        tMDtuO3LZzmBhEw+6LRyRpwDwZkGRAanFEjbL0UafFP1caC+G8tNpEwHVpsixHxPDZuOx2FRV+ODZ
        HN8r2AUB2tqhWx3yLj9hZ+8seCTqc0xaRJRGRucwzZr+rGUp5I//z9dMmJiw+qzp3/GKk4+dw3k1s
        J7XeNStNRw6sFr3ARGQ0Pt6aeyckHpePYXn5nbSgJ6peZKBicnrUD06LvrXmqN2WJ6yAMXwPsts/7
        Brrllw9Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kAnrc-0000DN-GQ; Wed, 26 Aug 2020 07:20:48 +0200
Received: from [2001:a61:25dc:8101:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kAnrc-000JAT-By; Wed, 26 Aug 2020 07:20:48 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: buffer-dmaengine: adjust `bytes_used` with residue info
Date:   Wed, 26 Aug 2020 07:20:11 +0200
Message-Id: <20200826052011.13348-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25910/Tue Aug 25 15:15:49 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

A transfer may fall shorter than the bytes in the block.
This information is available in the residue from the DMA engine, so we can
compute actual `bytes_used` with that by subtracting the residue.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 6dedf12b69a4..5789bda0745b 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -45,7 +45,8 @@ static struct dmaengine_buffer *iio_buffer_to_dmaengine_buffer(
 	return container_of(buffer, struct dmaengine_buffer, queue.buffer);
 }
 
-static void iio_dmaengine_buffer_block_done(void *data)
+static void iio_dmaengine_buffer_block_done(void *data,
+		const struct dmaengine_result *result)
 {
 	struct iio_dma_buffer_block *block = data;
 	unsigned long flags;
@@ -53,6 +54,7 @@ static void iio_dmaengine_buffer_block_done(void *data)
 	spin_lock_irqsave(&block->queue->list_lock, flags);
 	list_del(&block->head);
 	spin_unlock_irqrestore(&block->queue->list_lock, flags);
+	block->bytes_used -= result->residue;
 	iio_dma_buffer_block_done(block);
 }
 
@@ -74,7 +76,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	if (!desc)
 		return -ENOMEM;
 
-	desc->callback = iio_dmaengine_buffer_block_done;
+	desc->callback_result = iio_dmaengine_buffer_block_done;
 	desc->callback_param = block;
 
 	cookie = dmaengine_submit(desc);
-- 
2.20.1

