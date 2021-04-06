Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD53354F1E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhDFI4R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 04:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhDFI4R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 04:56:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E5EC061760
        for <linux-iio@vger.kernel.org>; Tue,  6 Apr 2021 01:56:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a12so3542601wrq.13
        for <linux-iio@vger.kernel.org>; Tue, 06 Apr 2021 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k0R/CpFQIO0LutUTt6whAWYDSEEYWanyJgecDTp2qS4=;
        b=OUtsvTywwF0/bDjP4cBmo4dT9qHLCQLOTKohdrUdMDdMtVgNZ88XIn0SLwDK4A4/qG
         EwEU/kFbpjoldb1LlsU7Sqe+FySEhPAaMbHfWEcGqojHKt4e7wg+lkYfX7k+1mdJfOVx
         AjbNMxpoKsRjSZwo0SNnNf4pUy1J3mi5/xwF4b9nJ8LW3P74wuWx4TkCXBTstUnV4lA7
         s0BPsgsPGkujSf2teVKDJ6yAKtQsmGArOMiabQxqM/i+PjKovEJjU6RlXGqdh4zTEWgS
         VM+UO6/Fxg6nQHnz7gGc/T35KZHHmhVOm5MYpNnNbtSejPeRXePMPVHTzDl4t2JCGmVy
         HLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k0R/CpFQIO0LutUTt6whAWYDSEEYWanyJgecDTp2qS4=;
        b=t1GC637UAq3S1xEJ78NK8ZqmxFfPNt5OkfA5v18/bhEhwwTUUc00BvwHhBWdg/htXw
         HkVICF63EFAKGkQ38bD4hhlpzVflZhVDuko+5utg1HqIRep2a6c4jDosqSbb6Ebgt0O3
         KLRa0OCyxhMpMsQuMwSxvWtOQ1TcPUm649m818HHVdp4lF8t2rD87thejrfC4rbdgAMt
         mIIeVQsyaN2cYjFPD1J1WL6iXB79RnssrxaY7rw51u6H7c6zoggWgeAuGw/6DaGPJNmF
         oJHO4qVGJpxYNGaS9oqs94vtg75qNa3VFM8I0XMDMmjpwpIPQ4itzG3vNKMXKlijnVOr
         4WfA==
X-Gm-Message-State: AOAM531vyk6kxwPI4jkoXIAGqn20CvBxWo15ABjkZ3EWFrExrtb5fg9+
        iqj57oqAI0TUjjg+4I5TkAqsSg==
X-Google-Smtp-Source: ABdhPJy5liwwM3Ot+2W70tIkjSPkDW++gyVE8uJhSgWpBItS06FaUlff1OXTLSFd9M921fWjlzp4KQ==
X-Received: by 2002:a5d:6b89:: with SMTP id n9mr33668042wrx.236.1617699367868;
        Tue, 06 Apr 2021 01:56:07 -0700 (PDT)
Received: from dell ([91.110.221.193])
        by smtp.gmail.com with ESMTPSA id u12sm5987318wro.51.2021.04.06.01.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:56:07 -0700 (PDT)
Date:   Tue, 6 Apr 2021 09:56:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anssi Hannula <anssi.hannula@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        Dario Pagani <dario.pagani.146+linuxk@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kim Kuparinen <kimi.h.kuparinen@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, Lopez Casado <nlopezcasad@logitech.com>,
        "L. Vinyard, Jr" <rvinyard@cs.nmsu.edu>,
        Masaki Ota <masaki.ota@jp.alps.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        message to <vojtech@ucw.cz>,
        Michael Haboustak <mike-@cinci.rr.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Zhang Lixu <lixu.zhang@intel.com>
Subject: Re: [RESEND 00/25] Rid W=1 warnings from HID
Message-ID: <20210406085605.GS2916463@dell>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021, Lee Jones wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (25):
>   HID: intel-ish-hid: Remove unused variable 'err'
>   HID: ishtp-hid-client: Move variable to where it's actually used
>   HID: intel-ish-hid: pci-ish: Remove unused variable 'ret'
>   HID: intel-ish: Supply some missing param descriptions
>   HID: intel-ish: Fix a naming disparity and a formatting error
>   HID: usbhid: Repair a formatting issue in a struct description
>   HID: intel-ish-hid: Fix a little doc-rot
>   HID: usbhid: hid-pidff: Demote a couple kernel-doc abuses
>   HID: hid-alps: Correct struct misnaming
>   HID: intel-ish-hid: Fix potential copy/paste error
>   HID: hid-core: Fix incorrect function name in header
>   HID: intel-ish-hid: ipc: Correct fw_reset_work_fn() function name in
>     header
>   HID: ishtp-hid-client: Fix incorrect function name report_bad_packet()
>   HID: hid-kye: Fix incorrect function name for kye_tablet_enable()
>   HID: hid-picolcd_core: Remove unused variable 'ret'
>   HID: hid-logitech-hidpp: Fix conformant kernel-doc header and demote
>     abuses
>   HID: hid-uclogic-rdesc: Kernel-doc is for functions and structs
>   HID: hid-thrustmaster: Demote a bunch of kernel-doc abuses
>   HID: hid-uclogic-params: Ensure function names are present and correct
>     in kernel-doc headers
>   HID: hid-sensor-custom: Remove unused variable 'ret'
>   HID: wacom_sys: Demote kernel-doc abuse
>   HID: hid-sensor-hub: Remove unused struct member 'quirks'
>   HID: hid-sensor-hub: Move 'hsdev' description to correct struct
>     definition
>   HID: intel-ish-hid: ishtp-fw-loader: Fix a bunch of formatting issues
>   HID: ishtp-hid-client: Fix 'suggest-attribute=format' compiler warning

These have been on the list for a couple of weeks now.

Is there anything I can do to help expedite their merge?

I'm concerned since -rc6 has just been released.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
