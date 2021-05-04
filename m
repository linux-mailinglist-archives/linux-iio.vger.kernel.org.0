Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D79372C0B
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEDObS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhEDObS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 10:31:18 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABDCC061574;
        Tue,  4 May 2021 07:30:23 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id u48-20020a4a97330000b02901fa060b8066so2043620ooi.8;
        Tue, 04 May 2021 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqiQvHVfJfAAUDigmjSoNJwQtL8DRDCYC39y1AeutfM=;
        b=LHgZ1taEvehqS/8XoOABNyFp08TZkQd4hoSIAXqvuR69lfYw/K+nOYjFv53gl5wDNb
         DQ8HrRRpEfH1BBysvURFZe1k5DpkjlnjCBFj1GbUssjAuWYqiXzJH8C6iVCbaJ889n3F
         YoazXNhVbjL5ae2xlW2G39gm+4T4knNOSXUvObCya8DRxnDxO9JZRpw7+EjEuZb4+LrQ
         zrTTLwlUODKzxFk0Tc6Vj+DEEdJk5K3z2aCZ2LG2/WfXdaxhC+5avqpfkFHOtzAhv/SU
         YH+w2SHynA5c2AvkEqSBfJ1mWG01LPpsZRpPa/Z8w4lD95WmfZGgou1/xsF/rVDzvWmp
         JDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MqiQvHVfJfAAUDigmjSoNJwQtL8DRDCYC39y1AeutfM=;
        b=LZycGEjJgT+uT6SFIriDpBOF5wMGWU2jZuH+DTFWR/6Q0aqveiieLniC5Wh6LsSq6D
         2ncvD1tHbQuAVOXpeg69oMvdM3ituroPxcTq9eD9gSF1a4DaPqb62+TRIIFSNTcsiDSJ
         +4MbgU2T+JhFXUeCKnOEIeNZlWuYrKglzBzeDppNzYKpeQgFLGhHsuZ8wUNHWJMqpDcf
         AYgaWTx8dRZGL6RrHtUaxA7csk7zLFoyE110r8RLt43Pk50LQzGhXT6BTsLwiCzhNWQj
         GFF6v+uPAf9GY652L6dhAZFAJ2Mqioyl6IY01EB7GyTglMfCzMczEZ3qvpb4pFjTwgHZ
         25ng==
X-Gm-Message-State: AOAM532iWHXvGeEcQ8cRBJ+NShFFvBvXwti8yZ0o/LrI2xtQFNk89BWJ
        AjKcF1MO/h63SUNYXxymTZGcWwPwO5U=
X-Google-Smtp-Source: ABdhPJzochAhFF6KL6MPRkZsKj/FB1DGzH871TqQ8wBtcol1YEJmEvg1hI5tDe8w3YFFGhYSfNHGfQ==
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr20088876oos.2.1620138622522;
        Tue, 04 May 2021 07:30:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m25sm666928oih.15.2021.05.04.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:30:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: am2315: Make am2315_acpi_id depend on CONFIG_ACPI
Date:   Tue,  4 May 2021 07:30:19 -0700
Message-Id: <20210504143019.2085111-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With CONFIG_ACPI=n and -Werror, 0-day reports:

drivers/iio/humidity/am2315.c:259:36: error:
	'am2315_acpi_id' defined but not used

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iio/humidity/am2315.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 23bc9c784ef4..e876b039c38f 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -256,12 +256,13 @@ static const struct i2c_device_id am2315_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id am2315_acpi_id[] = {
 	{"AOS2315", 0},
 	{}
 };
-
 MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
+#endif
 
 static struct i2c_driver am2315_driver = {
 	.driver = {
-- 
2.25.1

