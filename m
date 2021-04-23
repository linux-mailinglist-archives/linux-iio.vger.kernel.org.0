Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232B8368E9C
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhDWINn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 04:13:43 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net ([79.137.123.219]:37893 "EHLO
        smtpout1.mo3004.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241147AbhDWINn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 04:13:43 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 04:13:42 EDT
Received: from pro2.mail.ovh.net (unknown [10.109.138.36])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id ED1D223DA17;
        Fri, 23 Apr 2021 08:06:51 +0000 (UTC)
Received: from arch.lan (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Apr
 2021 10:06:51 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <ardeleanalex@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v2] iio: core: fix ioctl handlers removal
Date:   Fri, 23 Apr 2021 10:02:44 +0200
Message-ID: <20210423080244.2790-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 9231253336844360727
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhephedtgefgkeduvdekheeggefghffhteekleetvdekvddtveeutdetueefueehieetnecukfhppedtrddtrddtrddtpdekledrjedtrddvvddurdduleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheprghruggvlhgvrghnrghlvgigsehgmhgrihhlrdgtohhm
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently ioctl handlers are removed twice. For the first time during
iio_device_unregister() then later on inside
iio_device_unregister_eventset() and iio_buffers_free_sysfs_and_mask().
Double free leads to kernel panic.

Fix this by not touching ioctl handlers list directly but rather
letting code responsible for registration call the matching cleanup
routine itself.

Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
v2:
* add fixes tag and ack

 drivers/iio/industrialio-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d92c58a94fe4..98944cfc7331 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1939,9 +1939,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)

 	indio_dev->info = NULL;

-	list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
-		list_del(&h->entry);
-
 	iio_device_wakeup_eventset(indio_dev);
 	iio_buffer_wakeup_poll(indio_dev);

--
2.31.1

