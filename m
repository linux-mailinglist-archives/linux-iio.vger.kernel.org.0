Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1189226F9E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgGTUWt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 16:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbgGTUWt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 16:22:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31207C061794;
        Mon, 20 Jul 2020 13:22:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so485626pjq.5;
        Mon, 20 Jul 2020 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=8bjrXDZyMWjpGVDsBPulb9TLRFHHT3dN0jgYqBommVo=;
        b=ILuskQVn1e7trX9LpFdOjAGK6bgm6Vm9eNmxtzYcDDG7Ep5djtuBMe25PuV914Kr+x
         45pZbuM7RwazbpqpD0xWn7+jyPDkWhV3BAYep/dT/oRk8QqK6notTRXYyycy0EIXyzse
         LjiAG8gGVEZWCElL9IZPU7FSametRmGsnqmokjNT1Lg+sjz9xWvOI6X3GgZpbat7fOsc
         0G/Wh66t6SiZiVV7IE+KOhGxWStr93MdQAXxv1MC6RUQfQ71cqUv9wTb15aK2IWj0Lfv
         2SAPmWtRC0zETsQ/J37Hx9QWJx+iinp4STUsAnaPSs9ke6XQDqyCBNYtFXU7O0nBh9RK
         G3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=8bjrXDZyMWjpGVDsBPulb9TLRFHHT3dN0jgYqBommVo=;
        b=t32PbTRPiAK/72pZ4FhbSmtvejmT+R0b5b6bwqWkgAwANIxV+UGftXcuw4FzZLfwvy
         x6CVmNGY0xm2K2VuUPr31JIaTi24T/qgEMMzexxDZnuQ+LcAlClmEOXUS/ISjN0v2X1k
         w6PkADOgUELiCU3OfLitL8AqhCBqWrbiGDvLnUzbFgsTix9L2rVMSEfPJfVMU8XBkfJD
         44rZ8ZXWrj7OJlt9f6qypUtIf+XDyrdq92UTFNvxeAaNXJd6Kwn4oEnrvQczkpmQxdEP
         Abrsz1qQvZWvGP6TD5PWN1sfVtRs3c6xpnz1YQumpWNizvPkCjgTN307z48WgBxvtQML
         s2BA==
X-Gm-Message-State: AOAM531em8NH94A96yX6jDC1np16wytcU/waWOTgQOgtj/SHySnSI1QP
        2WwllDFqfDVKqY6+ayGhibb3b2UN
X-Google-Smtp-Source: ABdhPJyp4TAkT9bdZInushMMYP9C2SJ+kcSbtcSv2kg1Mtp5b/BDzaXllFs1InU9WEoBmZMfEKrPxw==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr19850760pls.38.1595276568625;
        Mon, 20 Jul 2020 13:22:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 129sm17218136pfv.161.2020.07.20.13.22.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 13:22:47 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/4] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Mon, 20 Jul 2020 13:22:39 -0700
Message-Id: <20200720202243.180230-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The EC reports a variety of error codes. Most of those, with the exception
of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
to Linux error codes to report a more meaningful error to the caller to aid
debugging.

To prepare for this change, handle error codes other than -EPROTO for all
callers of cros_ec_cmd_xfer_status(). Specifically, no longer assume that
-EPROTO reflects an error from the EC and all other error codes reflect a
transfer error.

v2: Add patches 1/4 to 3/4 to handle callers of cros_ec_cmd_xfer_status()

----------------------------------------------------------------
Guenter Roeck (4):
      iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
      cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
      platform/chrome: cros_ec_sysfs: Report range of error codes from EC
      platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes

 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  2 +-
 drivers/platform/chrome/cros_ec_lightbar.c         | 10 +++---
 drivers/platform/chrome/cros_ec_proto.c            | 37 +++++++++++++++++-----
 drivers/platform/chrome/cros_ec_sysfs.c            | 24 ++++++--------
 4 files changed, 43 insertions(+), 30 deletions(-)
