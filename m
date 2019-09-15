Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D66B2E81
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 07:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfIOF6g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 01:58:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42344 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfIOF6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 01:58:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id q12so175789pff.9;
        Sat, 14 Sep 2019 22:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+69t91mySr1Y3RDmoaArpwNBRCShDbP0VMxxF5Hw4c=;
        b=k68paORCiM4ipcEj+FeEqxakxlvScgiJdatDSr2gGTC4kJuQjXWFSdrVb96RoW+maB
         W5j5vc9ByIOscrr77XDxu+A0WHEVsAgRY3e9eCHeWC5ljqJUc1guddYtPhgRsVM2lMbr
         WabiU18IXB4MQEkPwlNkXHTWdpgd7aN+Rf7AakiIKVVTgor5/UNbhYECU10K9tWS29Jd
         DpYJRrl40VHGIz4ybDIrrD3uf28av+nki+f56E8/sroC2rU3vV9qlo2V7ToeAwiw73IC
         D9unR+VKWl4wcUcMgLZZq7vn/Tku7u5cw97/B2QE5Y52CZUd25y2gI528pDi0neu81Rk
         EL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+69t91mySr1Y3RDmoaArpwNBRCShDbP0VMxxF5Hw4c=;
        b=sg7v7vc3T8G4fiUuQ92eTAc4nFneWm3JmmT6HtXhLc8ojnB9Q/KYGIN2sOppxAWXtx
         9w57LMC2aG3BsANnyd0/K+NFhmVFmHHpkTFW3I8sRtHNVjRRnA3vXVr3lTy2igOQxioL
         PY+gzlid9zc9BA5e4ic2lLmAL97s9Ra9gTSd3SJxskrncmSyZSIn0lpH4QvhALPz4ZzC
         BgRYmFjmBzllZ8O2Gookaj8uXXPcRXDIIXuo/q27izMTzx+E98GX2JEdBQgdWf4qp8hb
         Qe6Jauc5x+Qb4zvbaQk/ugAvS7fpDFuCjX3X9wvH74TVCWh8k2iWFpoqlmuw8ZA+2rQu
         e4Jg==
X-Gm-Message-State: APjAAAWzG9596kOP+hrS0Kwv4fGfBRcsfwKf2fkiV/9fcC6UlwYjePqq
        uS767ykKygai7eypWY/K3s2yHcW1
X-Google-Smtp-Source: APXvYqxxGXWuxu0z1VNYCJ0vklBa4tmFHLk1e7U70fCG4vJSFlsT4rD20Q+nUdD0tf4eOIWeTXRxfA==
X-Received: by 2002:aa7:9688:: with SMTP id f8mr63122515pfk.77.1568527114887;
        Sat, 14 Sep 2019 22:58:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c144:8b8a:e7a2:82ca:6689:77bb])
        by smtp.gmail.com with ESMTPSA id 22sm3696658pfj.139.2019.09.14.22.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 22:58:33 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC 0/4] counter: Simplify count_read/count_write/signal_read
Date:   Sun, 15 Sep 2019 14:57:55 +0900
Message-Id: <20190915055759.408690-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I have a simplification for the the Counter subsystem callbacks, but I
want to get some comments first before committing further. Since this is
an RFC, I've included updates to the 104-QUAD-8 driver here for the
sake of demonstration; if the comments received are positive, I'll
submit the changes for the rest of the existing counter drivers as well.

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

William Breathitt Gray (4):
  counter: Simplify the count_read and count_write callbacks
  counter: Simplify the signal_read callback
  docs: driver-api: generic-counter: Update Count and Signal data types
  counter: 104-quad-8: Update count_read/count_write/signal_read
    callbacks

 Documentation/driver-api/generic-counter.rst |  22 ++--
 drivers/counter/104-quad-8.c                 |  33 ++----
 drivers/counter/counter.c                    | 101 +++----------------
 include/linux/counter.h                      |  74 ++------------
 4 files changed, 42 insertions(+), 188 deletions(-)

-- 
2.23.0

