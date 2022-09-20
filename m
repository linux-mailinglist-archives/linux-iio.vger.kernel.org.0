Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD85BEE20
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 22:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiITUBl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiITUBj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 16:01:39 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F350711
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 13:01:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r125so5162923oia.8
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=P8jvT0eT88DQzDdUaDee4Hy7fitgiXvq5+kBpjPcUZU=;
        b=u9xrS3HgsovTKxwmABBcHdFvsBLJAsw0rSWkgn1xBUL2Ij4BgesGQdbvkG8VMzQ+iu
         X2NjP9wabE6v1KrzR+QNwtaM9ZmhXx5UPG4ecjccDd9Bbv/V7P3FlMH0MTKFzjltPU2D
         coICSWifhYjm2FJirMKA+nmR+QaCYaCjCAEdZODsJTT90+uBk/veFzLMYWP7rCql4zpQ
         YS6ArXn/OWAYy9jPxHXLCWWcuHJKXsVtEdlhB/1GOMzbYeScBuX2Tjsm2qdl7NfNb9em
         +0f78fPpgNACvGTJ6rJXp0DZfay3DmPQw229WO3ZSlVplaYZDlMdnHrjDM6dQVeJ5Lg/
         pRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=P8jvT0eT88DQzDdUaDee4Hy7fitgiXvq5+kBpjPcUZU=;
        b=nx5glRyn3nP6+rlUdoymdQQnar5OmAclFZqW8v53I15ntzE84bh2x9fquwiko+nwSP
         l3UZWHDoXJiwZ25IoDrpHhF0PU5wZpjx3jZKLxg/iVrhdvqD+3D+mLRi5ukpqutt9zMX
         +rj+TOXE0lvUlyC4wYZBuVvWq/zAtUBlnXcqT4vKvuTD5XDZ1/4T+Jn0tiqNvDQCv8/S
         VHCWcZu71Jprb1Tos8Ih4RfXse7oatjBoCxm9K07UUhvF2bsGSas02T7+6Fpte7lXcQH
         fD/I6nYIfHOvt9FWV1Cuvg6pSu2aYwjQBYjQjRy2ZKkt0Rwis7MrQ70/cYk5ghcX2o0S
         hCdw==
X-Gm-Message-State: ACrzQf3tNbMT/1KhQDyQq++7Qi+clJ5JrbNE1jlXeiHpRWNdeewN+8gm
        Kcr6P1eT5b997PwrmO1fUO3Q7SA0uqb+Ow==
X-Google-Smtp-Source: AMsMyM7Nsb7OmY9kileiIjTwb2W/4+VLQ6dKwUnkqK2KH+8Bp6jkUTEu55S/9E98jaabrXMOvOykjw==
X-Received: by 2002:a05:6808:1a21:b0:350:61ee:832f with SMTP id bk33-20020a0568081a2100b0035061ee832fmr2480838oib.10.1663704098214;
        Tue, 20 Sep 2022 13:01:38 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bm43-20020a0568081aab00b0034d14c6ce3dsm325634oib.16.2022.09.20.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:01:37 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 0/5] Add support for Counter array components
Date:   Tue, 20 Sep 2022 13:21:24 -0400
Message-Id: <cover.1663693757.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v5:
 - Introduce the Count capture component
 - Add DEFINE_COUNTER_ARRAY_CAPTURE macro and COUNTER_COMP_ARRAY_CAPTURE
   for Counter arrays of capture elements
 - Fix Counter array handling in counter-chrdev.c; previously
   misinterpreted component id for COUNTER_COMPONENT_EXTENSION type when
   Counter array components were present

The COUNTER_COMP_ARRAY Counter component type is introduced to enable
support for Counter array components. With Counter array components,
exposure for buffers on counter devices can be defined via new Counter
array component macros. This should simplify code for driver authors who
would otherwise need to define individual Counter components for each
array element.

Eight Counter array component macros are introduced::

        DEFINE_COUNTER_ARRAY_U64(_name, _length)
        DEFINE_COUNTER_ARRAY_CAPTURE(_name, _length)
        DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length)
        COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_ARRAY_CAPTURE(_read, _write, _array)
        COUNTER_COMP_ARRAY_POLARITY(_read, _write, _array)

Eight Counter array callbacks are introduced as well::

        int (*signal_array_u32_read)(struct counter_device *counter,
                                     struct counter_signal *signal,
                                     size_t idx, u32 *val);
        int (*signal_array_u32_write)(struct counter_device *counter,
                                      struct counter_signal *signal,
                                      size_t idx, u32 val);
        int (*device_array_u64_read)(struct counter_device *counter,
                                     size_t idx, u64 *val);
        int (*count_array_u64_read)(struct counter_device *counter,
                                    struct counter_count *count,
                                    size_t idx, u64 *val);
        int (*signal_array_u64_read)(struct counter_device *counter,
                                     struct counter_signal *signal,
                                     size_t idx, u64 *val);
        int (*device_array_u64_write)(struct counter_device *counter,
                                      size_t idx, u64 val);
        int (*count_array_u64_write)(struct counter_device *counter,
                                     struct counter_count *count,
                                     size_t idx, u64 val);
        int (*signal_array_u64_write)(struct counter_device *counter,
                                      struct counter_signal *signal,
                                      size_t idx, u64 val);

Driver authors can handle reads/writes for an array component by
receiving an element index via the `idx` parameter and processing the
respective value via the `val` parameter.

For example, suppose a driver wants to expose a Count's read-only
capture buffer of four elements using a callback
`foobar_capture_read()`::

        DEFINE_COUNTER_ARRAY_CAPTURE(foobar_capture_array, 4);
        COUNTER_COMP_ARRAY_CAPTURE(foobar_capture_read, NULL,
                                   foobar_capture_array)

Respective sysfs attributes for each array element would appear for the
respective Count:

* /sys/bus/counter/devices/counterX/countY/capture0
* /sys/bus/counter/devices/counterX/countY/capture1
* /sys/bus/counter/devices/counterX/countY/capture2
* /sys/bus/counter/devices/counterX/countY/capture3

If a user tries to read _capture2_ for example, `idx` will be `2` when
passed to the `foobar_capture_read()` callback, and thus the driver
knows which array element to handle.

In addition, this patchset introduces the Signal polarity component,
which represents the active level of a respective Signal. There are two
possible states: positive (rising edge) and negative (falling edge). The
104-quad-8 driver is updated to expose its index_polarity functionality
via this new polarity component.

Counter arrays for polarity elements can be defined in a similar
manner as u64 elements::

        const enum counter_signal_polarity foobar_polarity_states[] = {
                COUNTER_SIGNAL_POLARITY_POSITIVE,
                COUNTER_SIGNAL_POLARITY_NEGATIVE,
        };
        DEFINE_COUNTER_ARRAY_POLARITY(foobar_polarity_array,
                                      foobar_polarity_states, 4);
        COUNTER_COMP_ARRAY_POLARITY(foobar_polarity_read,
                                    foobar_polarity_write,
                                    foobar_polarity_array)

The only component types supported for Counter arrays currently are
COUNTER_COMP_U64 and COUNTER_COMP_SIGNAL_POLARITY.

William Breathitt Gray (5):
  counter: Introduce the Signal polarity component
  counter: 104-quad-8: Add Signal polarity component
  counter: Introduce the Count capture component
  counter: Consolidate Counter extension sysfs attribute creation
  counter: Introduce the COUNTER_COMP_ARRAY component type

 Documentation/ABI/testing/sysfs-bus-counter |  19 ++
 drivers/counter/104-quad-8.c                |  35 +++
 drivers/counter/counter-chrdev.c            | 135 +++++++--
 drivers/counter/counter-sysfs.c             | 304 ++++++++++++++++----
 include/linux/counter.h                     | 147 ++++++++++
 include/uapi/linux/counter.h                |   8 +
 6 files changed, 581 insertions(+), 67 deletions(-)


base-commit: f95ec98139dc58db72e4bd0df049a3097990a8e7
-- 
2.37.3

