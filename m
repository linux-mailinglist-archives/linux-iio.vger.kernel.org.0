Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E493900DC
	for <lists+linux-iio@lfdr.de>; Tue, 25 May 2021 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhEYMZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 May 2021 08:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232305AbhEYMZ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 May 2021 08:25:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0D0361409;
        Tue, 25 May 2021 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621945438;
        bh=sriZ/GA+KVZn8IQOjLCkBr9AX4FKzSKvGn0xqPQ5O9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LO1BMNviHxXyhfwBtxtUtlrJYs/qVYeGYF+b+2mxL1byOG9xlwlcZp4E1O5bys9ZC
         ABKLMwEM793CJe0ftkcFDV7P4y/cxpTL2v682EZ3AN2WU2/8Jc5RiCw+kr5ofeYtHw
         XiQyyV7E/tTOeTJMynAc1qOGXSt9/lf+IMqMJeVmrtBNcG72L3M5ls+eFBI3nfoBB5
         O+6dW6lfSJGW84YiCec+tKrNz45wQ9edvlJz+S9tzx6v+N5iILVK/6W06TydfDBt0l
         xmeM95xWmY3INLQ63z8MQ5DGV/C+B73MLQj4h33NdAyEEsbi2BfaCWuRhM/QP7ICSp
         I5aryZQamhgwQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1llW6G-000tUD-L1; Tue, 25 May 2021 14:23:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/2] iio: ABI: sysfs-bus-iio: avoid a warning when doc is built
Date:   Tue, 25 May 2021 14:23:53 +0200
Message-Id: <dbf0d94f85217f103d77dc8389c8db272f5702d2.1621944866.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621944866.git.mchehab+huawei@kernel.org>
References: <cover.1621944866.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The description of those vars produce this warning:
  Documentation/ABI/testing/sysfs-bus-iio:799: WARNING: Inline emphasis start-string without end-string.

Due to an asterisk, which is the markup for emphasis. One possible
fix would be to use ``*_timeout`` to avoid it, but looking at
the descriptions of other fields in this file, a common pattern
is to refer to "these" when talking about the API calls that
are described.

So, change the text in order to preserve the meaning while
avoiding the need of using an asterisk there.

Reported-by: Jonathan Corbet <corbet@lwn.net>
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 433fe0ab74be..dcc52828a204 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -801,7 +801,7 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		When adaptive thresholds are used, the tracking signal
 		may adjust too slowly to step changes in the raw signal.
-		*_timeout (in seconds) specifies a time for which the
+		Thus these specifiy the time in seconds for which the
 		difference between the slow tracking signal and the raw
 		signal is allowed to remain out-of-range before a reset
 		event occurs in which the tracking signal is made equal
-- 
2.31.1

