Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2C3900DF
	for <lists+linux-iio@lfdr.de>; Tue, 25 May 2021 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhEYMZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 May 2021 08:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhEYMZ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 May 2021 08:25:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB0C26141B;
        Tue, 25 May 2021 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621945438;
        bh=hNnIxDot3NHBeoFyfLLKf6DA+9JTA6v3PREzAxXDPik=;
        h=From:To:Cc:Subject:Date:From;
        b=JjVcnlLJp37XWyBMOEPp4MDpzckpzZ84UO7BCJmZdfs9l7DwgyQULZ8vWd1fjMh9t
         wPowWGwYk7UZzEaJQYjXeLqc0SpoV2peUtTPcYnB7SPWMZzglq/uZ/ezwxjV0QNuU1
         jDONCdkgyg0fSo3h097l148LQTC/8FASZE9Oh/L1MRsEfIO0o5iroDZ9iCzELGdPg0
         fTZiVGQgi1k++DixaFaKxoMMrYn+hpxmu8J08294R+nze7OHNDMqTHulBT4oaW5RvN
         TKUWT5p7vesZoLjZjtmX6Epe82FGMMPPhVRwnV+wH6pQP56t+mvesrUNjq97WK3WKy
         va2TO3px8YWfQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1llW6G-000tU7-Iz; Tue, 25 May 2021 14:23:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/2] doc: add a couple fixups for IIO ABI files
Date:   Tue, 25 May 2021 14:23:51 +0200
Message-Id: <cover.1621944866.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Patch 1 was already submitted as patch 10/10 on this series:
	https://lore.kernel.org/linux-doc/87wnrtnpko.fsf@meer.lwn.net/

However, it generated a new warning, due to a separate issue.

So, resend it together with a warning fix patch.

As these patches are independent from the other ones, I guess it
can either be applied via IIO or via docs tree, whatever works
best for the doc and IIO maintainers.
So, I should leave such decision to Jonathan & Jonathan ;-)

Mauro Carvalho Chehab (2):
  iio: ABI: sysfs-bus-iio: fix a typo
  iio: ABI: sysfs-bus-iio: avoid a warning when doc is built

 Documentation/ABI/testing/sysfs-bus-iio | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.31.1


