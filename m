Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6C9CD34C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJFQDa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 12:03:30 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34066 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJFQDa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 12:03:30 -0400
Received: by mail-yb1-f196.google.com with SMTP id m1so3851667ybm.1;
        Sun, 06 Oct 2019 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVq3A/TrWA22YphYYB+8No5n6QtHAxN2b6l0mk2+kwE=;
        b=El+CWmCQb7R1fo1oaYIeiyEHx3GBZV4IoBkFhd03r6gfzUl03znZ2gdd9tCnotz27U
         qf720XYBzApe7w5zHR9EQ6v6qxaoiJ5P9Fv4DLS63DpPZMaPPr63LQSba6an/X8SQW1F
         wesEJwGo4JmAzqcHtXkfzFjqWqLwiPIGkfiWAQEEVWIXy0KiwgPiID4CLh8oNGf2QE4L
         oMnBwWRUXXmq8b/G9vNjukYF3TjiQYfjtZ50CTj7AM+lZKrKH7DPJ32tDdThMa2rkBE4
         QZ5fEmkYrXC/KK+7mWFL8+mM9dUFjPx2IhQ2uAZKSely5VF+4GYckmZy2jflNlF8iB42
         qfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVq3A/TrWA22YphYYB+8No5n6QtHAxN2b6l0mk2+kwE=;
        b=fCdyYNU1WeaJfruU+9pX7r9fC+Tn7/U4bGaCIH7MyUKp0WHzUV3OkeIJZC9zqKLRQu
         1NqUKwfuGaqn6AjKpDaSTGfa2d5cPAFpqXPsaOabS7CQtoWU5fNnQ6DPmBFFIiT4zMD1
         6U12f+/ZRyxjjn2DthNCxvaSTpbTsoXJ8a5ycmNm7OEHozQXBFs7h7m14aIQ4occH1mV
         kzc8SOP9RpGGJBVErtGcKhWavTKqAVMR7q6hmFRlgRN5Y3r0BLmn4ZFjLTUShENM1ViM
         vdmca6o3i1oSJcjY2P/BoS5+PwbearHvsS1rm8BJKCkQiMjlX/+fd3jQdH65LCW7zvd0
         ihlA==
X-Gm-Message-State: APjAAAXnl27L9jalkDeg4BUpwa4Ofw60ruKjkDZ1qI1DHMByMKY3Av+V
        N7Z0VXFjOc/YwTvELSLBLjE=
X-Google-Smtp-Source: APXvYqyT7gjrdIuAXN+Bwn4RKda6PPR1sKi1ETOlqbj7vb1Sy27HtwuzkOxhz14rXqUdFFOvXtIc3Q==
X-Received: by 2002:a25:ab21:: with SMTP id u30mr3900549ybi.143.1570377808701;
        Sun, 06 Oct 2019 09:03:28 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id y129sm3341816ywy.41.2019.10.06.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 09:03:27 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        david@lechnology.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 0/2] Simplify count_read/count_write/signal_read
Date:   Sun,  6 Oct 2019 12:03:09 -0400
Message-Id: <cover.1570377521.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v4:
 - Rebase ontop of ti-eqep introduction patches and update ti-eqep

The changes in this patchset will not affect the userspace interface.
Rather, these changes are intended to simplify the kernelspace Counter
callbacks for counter device driver authors.

The following main changes are proposed:

* Retire the opaque counter_count_read_value/counter_count_write_value
  structures and simply represent count data as an unsigned integer.

* Retire the opaque counter_signal_read_value structure and represent
  Signal data as a counter_signal_value enum.

These changes should reduce some complexity and code in the use and
implementation of the count_read, count_write, and signal_read
callbacks.

The opaque structures for Count data and Signal data were introduced
originally in anticipation of supporting various representations of
counter data (e.g. arbitrary-precision tallies, floating-point spherical
coordinate positions, etc). However, with the counter device drivers
that have appeared, it's become apparent that utilizing opaque
structures in kernelspace is not the best approach to take.

I believe it is best to let userspace applications decide how to
interpret the count data they receive. There are a couple of reasons why
it would be good to do so:

* Users use their devices in unexpected ways.

  For example, a quadrature encoder counter device is typically used to
  keep track of the position of a motor, but a user could set the device
  in a pulse-direction mode and instead use it to count sporadic rising
  edges from an arbitrary signal line unrelated to positioning. Users
  should have the freedom to decide what their data represents.

* Most counter devices represent data as unsigned integers anyway.

  For example, whether the device is a tally counter or position
  counter, the count data is represented to the user as an unsigned
  integer value. So specifying that one device is representing tallies
  while the other specifies positions does not provide much utility from
  an interface perspective.

For these reasons, the count_read and count_write callbacks have been
redefined to pass count data directly as unsigned long instead of passed
via opaque structures:

        count_read(struct counter_device *counter,
                   struct counter_count *count, unsigned long *val);
        count_write(struct counter_device *counter,
                    struct counter_count *count, unsigned long val);

Similarly, the signal_read is redefined to pass Signal data directly as
a counter_signal_value enum instead of via an opaque structure:

        signal_read(struct counter_device *counter,
                    struct counter_signal *signal,
                    enum counter_signal_value *val);

The counter_signal_value enum is simply the counter_signal_level enum
redefined to remove the references to the Signal data "level" data type.

William Breathitt Gray (2):
  counter: Simplify the count_read and count_write callbacks
  docs: driver-api: generic-counter: Update Count and Signal data types

 Documentation/driver-api/generic-counter.rst |  22 ++--
 drivers/counter/104-quad-8.c                 |  33 ++----
 drivers/counter/counter.c                    | 101 +++----------------
 drivers/counter/ftm-quaddec.c                |  14 +--
 drivers/counter/stm32-lptimer-cnt.c          |   5 +-
 drivers/counter/stm32-timer-cnt.c            |  17 +---
 drivers/counter/ti-eqep.c                    |  19 ++--
 include/linux/counter.h                      |  74 ++------------
 8 files changed, 59 insertions(+), 226 deletions(-)


base-commit: 0c3aa63a842d84990bd02622f2fa50d2bd33c652
prerequisite-patch-id: ebe284609b3db8d4130ea2915f7f7b185c743a70
prerequisite-patch-id: cbe857759f10d875690df125d18bc04f585ac7c9
prerequisite-patch-id: 21f2660dc88627387ee4666d08044c63dd961dae
-- 
2.23.0

