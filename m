Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907C24D9CC
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFTSxI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 14:53:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43208 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfFTSxH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 14:53:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so2028980pgv.10
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2019 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y38qr/fYJ7o3rsLs1bn8D1I8msndSGvVmOkbAWHtFu8=;
        b=kPzLnsqwupLhY4EZRC2++uwK6KDFRIKIHrbSBuqhJenumTiCZhEp6qUgyUMm4IQo3s
         pIe1OKuxICWQ66cYuUPT2BjJ+T3KWzMEZMFh2ZTkB4wKMPP8ELc40NdNObx0ewcJG7V3
         g/1TXKf5dV0qLm/mpNeKx3Hqj+IXoGBjURyCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y38qr/fYJ7o3rsLs1bn8D1I8msndSGvVmOkbAWHtFu8=;
        b=gpgsK5c8r6xrdgKYIJ2Dr6fiNr/JH5uU7p9MSzPXlUQcqn5ce+2vB/9MpfM+Cp+h8P
         ueJ2jga+PoDdY113qRWyIhegGSQK+lC0S1oageXPklxMDUG+w6a54ynrBV0BY4XsAaMk
         w9oVB86b82lndZ59KX3Ib0WBGi2jBzMVSDt+BbqjVQfk9J1HP54ja1HTKqfa8RKgNJk5
         s6Sj9/TVykUOL5mGgVIZKwbEYLuTxfnFTNPclmlyjHd7dhQLQypzdv34CtH0mlWL0ZtY
         /i4sisEdPVHg9xnoqKSUKtUl3lk5vIBBusptDLdmpZDNtpAmW6TokCiowlg++ieVHZ/h
         LZdw==
X-Gm-Message-State: APjAAAVWaK/RYGFiq9Gz1GtcZPkk79HR7bdQwepr0agLud+0t7Z48Zh1
        R16PvuGg9ZdF29gS/X5fL7ckQg==
X-Google-Smtp-Source: APXvYqy/S7xo8/qezVDAb9cQUvhK9pinm4zGcjvF82lt2eXn6/alia4P00FdiTMtFl6AxG/C0hTr3A==
X-Received: by 2002:a63:90c8:: with SMTP id a191mr4334695pge.112.1561056786935;
        Thu, 20 Jun 2019 11:53:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m6sm485194pjl.18.2019.06.20.11.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 11:53:06 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] Support accelerometers for veyron_minnie
Date:   Thu, 20 Jun 2019 11:52:57 -0700
Message-Id: <20190620185259.142133-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
controls two accelerometers, one in the lid, one in the base.
However, the EC firmware does not follow the new interface that
cros_ec_accel driver use.
Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
Chromebook - to veyron_minnie.
veyron_minnie being ARM based, issue command over the I2C bus to the EC
instead of relying on the shared registers over LPC.

Gwendal Grignou (2):
  iio: cros_ec: Add sign vector in core for backward compatibility
  iio: cros_ec : Extend legacy support to ARM device

 drivers/iio/accel/Kconfig                     |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      | 353 ++++--------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   5 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 4 files changed, 84 insertions(+), 279 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

