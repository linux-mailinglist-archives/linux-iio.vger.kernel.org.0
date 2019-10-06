Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53CECD90A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfJFUDb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 16:03:31 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33081 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJFUDa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 16:03:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id w140so2698465ywd.0;
        Sun, 06 Oct 2019 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAD87elW3s517JLI2iTshbAxE2vtTeLTbEEr73+JTTo=;
        b=b8u9n4PhEviR3wP/yj+0PudSJxU/RYT93LpSALa8ko5AoW/fdnOhLH4/2mPEAfDvAT
         LHvEgW6OrV4EhOgcB/pPShK15w3OhQrky7AEqW3EY+LTTmGJopYUVXngibHNt2zzZfht
         XXSkY+gnBjhk0cmctHEciW2t9Ql/5hJW2IAbruDjuPHgTMpmxW4zVImSfzH7Lp4qDu8a
         5WkgNMbHjtPP1dCrLdtfA44CJV9v+AQi1gV1AJrHa04fuFkzj7x4eYmwcwocemaIAcnV
         uCshn4YyfgwT1DkAPBy1hYWXAg5KPYFjYoUGQT/X9AVU4QOhvb4JzjS2me3V3wb9H6xr
         BTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAD87elW3s517JLI2iTshbAxE2vtTeLTbEEr73+JTTo=;
        b=eU3Ua4+qeRH7JXzdxhCZGaSlD5tLICyTv8XSM1bCMdNXi6D606fStZBcylbdKL+SRV
         4pkLupvrrfTAL0fC/hHygVohZhdIUz79y6P8ZnyQk1K9S1CI1AC33BWTNyqot5wkJNpj
         Ybduh6RFvfoJumSiId3UvIvza1odHkBJvKbFsJby5cRw7etIUdq8bObyyyrpBBn5/pkJ
         oWEdbbNLef6c6QIphwwD913nQL8l/LNm0KpS+6zw1I795Ja5dXRfO+Y5JXWzxpYm2NIq
         PHO6+4fa8+9koum3vMUqy7fNtsn84Z/yatCFIC/V06y3etSACxfx7kCGQCnCgwBJzsPc
         sL1A==
X-Gm-Message-State: APjAAAVNSNwagCYkN4AbAscPrEa4JdkaegQOxsGkdG0TtMDBCI5T1tt6
        HDbH6JrKbMN+0/XiREwV9au9uPaS
X-Google-Smtp-Source: APXvYqyQPcYRjH/0i8mxOghstPu0yUg69Or8AFQkg1v3xcY/ad8RpW1sQgbaxICtMnMxyHWdaKP62w==
X-Received: by 2002:a81:ee06:: with SMTP id l6mr13525880ywm.357.1570392209362;
        Sun, 06 Oct 2019 13:03:29 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id x16sm3765266ywx.103.2019.10.06.13.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 13:03:28 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        david@lechnology.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 0/3] Simplify count_read/count_write/signal_read
Date:   Sun,  6 Oct 2019 16:03:08 -0400
Message-Id: <cover.1570391994.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v5:
 - Add changes and additions to generic-counter.rst to clarify theory
   and use of the Generic Counter interface
 - Fix typo in counter.h action_get description comment

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

William Breathitt Gray (3):
  counter: Simplify the count_read and count_write callbacks
  docs: driver-api: generic-counter: Update Count and Signal data types
  counter: Fix typo in action_get description

 Documentation/driver-api/generic-counter.rst | 162 +++++++++++--------
 drivers/counter/104-quad-8.c                 |  33 ++--
 drivers/counter/counter.c                    | 101 ++----------
 drivers/counter/ftm-quaddec.c                |  14 +-
 drivers/counter/stm32-lptimer-cnt.c          |   5 +-
 drivers/counter/stm32-timer-cnt.c            |  17 +-
 drivers/counter/ti-eqep.c                    |  19 +--
 include/linux/counter.h                      |  76 ++-------
 8 files changed, 144 insertions(+), 283 deletions(-)


base-commit: 0c3aa63a842d84990bd02622f2fa50d2bd33c652
prerequisite-patch-id: ebe284609b3db8d4130ea2915f7f7b185c743a70
prerequisite-patch-id: cbe857759f10d875690df125d18bc04f585ac7c9
prerequisite-patch-id: 21f2660dc88627387ee4666d08044c63dd961dae
-- 
2.23.0

