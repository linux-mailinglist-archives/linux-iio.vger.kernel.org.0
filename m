Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D16421E71
	for <lists+linux-iio@lfdr.de>; Tue,  5 Oct 2021 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhJEFxv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Oct 2021 01:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhJEFxv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Oct 2021 01:53:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A146C061745;
        Mon,  4 Oct 2021 22:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1XQZGVwYmPJS3p+DdVicrs9TzBUoo6qW7dRI91zPfCY=; b=n9PQUJCzCkyiJwAheTY/dq9VLp
        16iqD8SgMICb6ENH3VGApBOj6GMC1mZCz3kdDo++JBLPFpyB8tGI/gbNXJr8cQPVGGevU9yS5H/ld
        4v3fYGmXodSHBNABiwqAW8OMpahCPXrBheGjnGox4N6HR/4htrVStAUNMTaV9FEyomNvRN/KBPIe2
        q2KisVXo8soyK2zX/d1bLYnTLYJymJH8PnFkTC6whhI9FGEEt254zfrOna4Iik4r9EHibYDtmBRMY
        Fim+4gyofPTP8AbMoRAMZ+N5gyZbWLSjQgAWVpwNrexypZbBSYBVmtBck8cIrsXp5z9csj6VB0MAI
        yvrCTg4w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXdMs-0091xC-Sv; Tue, 05 Oct 2021 05:51:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH -next] counter: fix docum. build problems after filename change
Date:   Mon,  4 Oct 2021 22:51:57 -0700
Message-Id: <20211005055157.22937-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix documentation build warnings due to a source file being
renamed.

WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -sphinx-version 1.8.5 -export ../drivers/counter/counter.c' failed with return code 2

Error: Cannot open file ../drivers/counter/counter.c

Fixes: d70e46af7531 ("counter: Internalize sysfs interface code")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/driver-api/generic-counter.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211001.orig/Documentation/driver-api/generic-counter.rst
+++ linux-next-20211001/Documentation/driver-api/generic-counter.rst
@@ -247,7 +247,7 @@ for defining a counter device.
 .. kernel-doc:: include/linux/counter.h
    :internal:
 
-.. kernel-doc:: drivers/counter/counter.c
+.. kernel-doc:: drivers/counter/counter-core.c
    :export:
 
 Driver Implementation
