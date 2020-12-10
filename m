Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB12D6ACD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 23:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgLJWbC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 17:31:02 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:33256 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405081AbgLJWVZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 17:21:25 -0500
Received: by mail-pf1-f178.google.com with SMTP id p4so5498150pfg.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EbSo0ik3oE/pUntpHbdUmKeawpYRPGusD8KkmWQ96dE=;
        b=eAVcTr9bcBEgfiatQ3ur9aZs2hoZctbXlZXVYHQyXgq3MwpVpmGMiZleKqGBxjUefd
         Mwd27ELJ3AD11AfaJrdau7x/DvohDtqv/sSS9PKTe1X0PceDEmtcusD+lagy5Fb07iAO
         50g4QN7zv7/6HcbI36E4Rs1qp7F+gAVM+zlmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EbSo0ik3oE/pUntpHbdUmKeawpYRPGusD8KkmWQ96dE=;
        b=IYH1rx9FXkTj7GmUXDz+xhpe4clKKbnfJF+nZgmAQ4voTqHexK288x3Sqoz3rhaYu7
         vaxz8HUeBHdY8gCgzK459uh7ClIXTlvGSt3h9UWtNv/G6DyR1yUo4hN230gH9myc4Wuj
         Fi6OTVjmaKmJy2MSlmr8jdgTJUjfoYdvrx8lJGjm//m7YPkd/xPF9Xom91b2MUe+MIRZ
         DGmp5w9vclrTX6Va17jQ1GyY3EeunQn5tN93VIfpmVs8EzdRV5GNM1Q/ewNWLpTjEVWM
         4sJr6w9YF5xl325zJJ2DwGN6RjqZ96yWA0ywSdBUdmjMiaUInN/0vR2BMB7IYoha9ufI
         YkSw==
X-Gm-Message-State: AOAM5333j4ouy8Ahu9HOLElSY4vApLtdP/osQsFgnL2PozQMEqcbh6Yx
        BH5l7wZ17we2BNmyAUHL366yG1DwY6DoBg==
X-Google-Smtp-Source: ABdhPJxg242tHTGDe4AiLjiNx1CjsYRBy7QADuoGgzq+/2KYcCtRyMGNeg6ovtN6t0hceXPvvbIYjw==
X-Received: by 2002:a17:90b:4b87:: with SMTP id lr7mr9708093pjb.40.1607638544507;
        Thu, 10 Dec 2020 14:15:44 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id n195sm3953072pfd.169.2020.12.10.14.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 14:15:43 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/2] iio: acpi_als: Add sotfware trigger support
Date:   Thu, 10 Dec 2020 14:15:39 -0800
Message-Id: <20201210221541.1180448-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices (chromebooks) present the ACPI ALS device but do not have
ability to notify when a new sample is present.
Add support for software trigger (hrtimer/sysfs-trigger) to allow
retrieving samples using iio buffers.

The first path fully adds timestamp channel, the next one adds trigger
support.

This patch assumes the patch "iio: set default trig->dev.parent" is
applied.

Fix a pointer error in v3.

Gwendal Grignou (2):
  iio: acpi_als: Add timestamp channel
  iio: acpi_als: Add trigger support

 drivers/iio/light/acpi-als.c | 103 ++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 31 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

