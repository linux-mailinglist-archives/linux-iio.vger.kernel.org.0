Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248F49165B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 13:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHRLXK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 07:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRLXJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 07:23:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D11183F3B;
        Sun, 18 Aug 2019 11:23:09 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8863F85793;
        Sun, 18 Aug 2019 11:23:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: kxcjk1013: Improve comments on KIOX010A and KIOX020A ACPI ids
Date:   Sun, 18 Aug 2019 13:23:06 +0200
Message-Id: <20190818112306.21236-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 18 Aug 2019 11:23:09 +0000 (UTC)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The KIOX010A and KIOX020A ACPI ids go hand in hand, they are used in
yoga style 2-in-1s, with KIOX010A indicating the KXCJ91008 sensor in the
display of the 2-in-1 and KIOX020A indicating the KXCJ91008 sensor in the
base.

Improve the existing comment on the "KIOX010A" kx_acpi_match table entry
to make clear we are talking about a yoga-style (360 degree hinges) device
here and add a similar comment to the "KIOX020A" entry.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 6645771aa349..fee535d6e45b 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1486,8 +1486,8 @@ static const struct acpi_device_id kx_acpi_match[] = {
 	{"KIOX0008", KXCJ91008},
 	{"KIOX0009", KXTJ21009},
 	{"KIOX000A", KXCJ91008},
-	{"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 */
-	{"KIOX020A", KXCJ91008},
+	{"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-in-1 */
+	{"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-1 */
 	{"KXTJ1009", KXTJ21009},
 	{"KXJ2109",  KXTJ21009},
 	{"SMO8500",  KXCJ91008},
-- 
2.23.0.rc2

