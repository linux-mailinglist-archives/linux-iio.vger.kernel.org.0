Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8420D440ED4
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhJaOY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:29 -0400
Received: from www381.your-server.de ([78.46.137.84]:57564 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=fXyLFYpO7MHX+UysTp1rA6w31K5uVIJG/V9NQZ55MB0=; b=Gct3Ub02HS88vz8mZzC+902gts
        momgXXKttjw1DUa2lNYv9urWimK5kU4P+6kQscp4N76lu6EqiOB21KM4KAoNAuX/UIkqhN0q3P+mU
        iQxGpSkFIUQHRbAlW+eEs0K1aCBW9S9NL9S31iW2QqGkjLE1dt3WERrEmTpOa+r2+eLvWrH3Dm37Q
        A/aHOyCLIyqkd4oQE+8lDds1YQ7HPMFB8DclULTEhzai9BMJOAxgl7qsitonh+gWc3wdXiVpJBlwN
        cYeMDILuOjzTJSIHaR7lrN3qtVngkRE/+NGZPXtRt5vdxkYK+7kIBuvDF9PWHLStN8HLooxDQtsNN
        TdvUHI6Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-00069C-AV; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000F2T-4N; Sun, 31 Oct 2021 15:21:54 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/9] iio: afe4404: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:26 +0100
Message-Id: <20211031142130.20791-5-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211031142130.20791-1-lars@metafoo.de>
References: <20211031142130.20791-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26339/Sun Oct 31 09:18:16 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO core handles a trigger ops with all NULL callbacks the
same as if the trigger ops itself was NULL.

Remove the empty trigger ops from the interrupt trigger driver to slightly
reduce the boilerplate code. Object size of the driver module is also
slightly reduced.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/health/afe4404.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 7ef3f5e34de5..aa9311e1e655 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -347,9 +347,6 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static const struct iio_trigger_ops afe4404_trigger_ops = {
-};
-
 /* Default timings from data-sheet */
 #define AFE4404_TIMING_PAIRS			\
 	{ AFE440X_PRPCOUNT,	39999	},	\
@@ -537,8 +534,6 @@ static int afe4404_probe(struct i2c_client *client,
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
-		afe->trig->ops = &afe4404_trigger_ops;
-
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
 			dev_err(afe->dev, "Unable to register IIO trigger\n");
-- 
2.20.1

