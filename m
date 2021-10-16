Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97604303C0
	for <lists+linux-iio@lfdr.de>; Sat, 16 Oct 2021 18:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbhJPQaN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbhJPQaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Oct 2021 12:30:11 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3DC061570;
        Sat, 16 Oct 2021 09:28:02 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v195so1268191ybb.0;
        Sat, 16 Oct 2021 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Id1MBaA3OETXuAI2hYM+99prITp5edRSGDU+gsvnGcE=;
        b=NuSoPB2r7ZFwbh+xm3eq2YpuuZVI5PU0ML/nreO75bHdMjPx2e4dYImScZe8g/Z5vt
         xTOOaSRYPpP2AGLSgpKT9X5sktrT5wXlZBzEPBaAMQTOzBtNGz5IjUbSaQRzNgxNJXLy
         HdtCJz+XxkongIkQ0k/PopdAnG1E8o3rgCaDQa1gBcUOEMFEN5GVI4LZTzLFBSS/CGzw
         /Q15qfaoeRjnoGpPh8ZmYBsIja3EJsQLnAbaZIzSwt6VZ5rlu3xwmjBWQDhfZ6u9/qXV
         gc+V7G2uz/xPq3kZj1G+zm8djZrl63t2NHpRt1NHWDPbUckEGqg4o09VxKZls4yfy+lf
         u9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Id1MBaA3OETXuAI2hYM+99prITp5edRSGDU+gsvnGcE=;
        b=E0WDgDQNwfQ3uG5phRlPNIRMIY4yrR3FReOLtoSkqy9NcXzpTdUfPsf7NYMDDw61Qw
         QFYfnes0e57XGBy3l6AkitMVwZ5+mWUFRn0ZVJ/wcOiQeCIGcfCgLjB/JmjgL9Bffdul
         hsPP7vFF/x7KjAeMBv4En6AZ1BXxazyPKKbNZZGVGs2q9eDZsiCFQczq3+RZVHC6PeiR
         insCvDNXYDUrkRDCEbaTaiS0jz5/uK25K8WGLMNcXnkpi/WSzIKZyAGZjbNPb9PTUCQr
         /bPs9uR6fy6RChTFD085H41w67rcxlZPpS6cndygschjsq3hA6jXWuhe9LKC4ut3HEVq
         Xczw==
X-Gm-Message-State: AOAM533Q9QPfUmk64VOQk9fM56hhq59j3n76CzwQV1Oh9iXVSMRYzzBu
        xVjUHHbplquuPnhqSlJv0cTizYdEvui1kiRD3xvJBg2bnGA=
X-Google-Smtp-Source: ABdhPJyfGyzFUeWi79yeeWVZEumWi4upZfkpiyd4s2wo5sTM0Siy6+UeUwn8j6UfXBqfuU0rk1Gc+10/1CUdlG1yWhY=
X-Received: by 2002:a25:ddc7:: with SMTP id u190mr19198236ybg.37.1634401681179;
 Sat, 16 Oct 2021 09:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
In-Reply-To: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
From:   Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Sat, 16 Oct 2021 19:27:50 +0300
Message-ID: <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a1125305ce7acbd8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--000000000000a1125305ce7acbd8
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 16, 2021 at 7:19 PM Maxim Levitsky <maximlevitsky@gmail.com> wrote:
>
> I recently bought this device, and it has this accelerometer/gyroscope.
>
> Unfortunately, the device is advertised in ACPI as 10EC5280, instead of BMI0160
>
> I attached a patch that does add this 10EC5280 to the list of ACPI ids of this driver, and the device seems to work fine, showing both acceleration and angular velocity in /sys IIO attributes with reasonable values.
>

( resend using plain text - reminds me to never use Gmail's web
interface, even on weekends .)

> Best regards,
>    Maxim Levitsky

--000000000000a1125305ce7acbd8
Content-Type: text/x-patch; charset="US-ASCII"; name="accel_fix.patch"
Content-Disposition: attachment; filename="accel_fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kuu0jvju0>
X-Attachment-Id: f_kuu0jvju0

Y29tbWl0IDg4MGJiZjJlNWVlMmZhMGU5OTc5ODQ4MjY2NDk5N2E3ZGIyMjVmNTYKQXV0aG9yOiBN
YXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNvbT4KRGF0ZTogICBTYXQgT2N0IDIgMjA6
NTQ6MDAgMjAyMSArMDMwMAoKICAgIEJNSTE2MDogQVlBIE5FQSBhY2NlbG9tZXRlciBJRAogICAg
CiAgICBPbiBBWUEgTkVPLCB0aGUgYWNjZWxlcm9tZXRlciBpcyBCTUkxNjAgYnV0IGl0IGlzIGV4
cG9zZWQKICAgIHZpYSBBQ1BJIGFzIDEwRUM1MjgwCiAgICAKICAgIFNpZ25lZC1vZmYtYnk6IE1h
eGltIExldml0c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aWlvL2ltdS9ibWkxNjAvYm1pMTYwX2kyYy5jIGIvZHJpdmVycy9paW8vaW11L2JtaTE2MC9ibWkx
NjBfaTJjLmMKaW5kZXggMjYzOTg2MTRlZGRmYS4uMmIzZTNlMTVlMmUwNCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9paW8vaW11L2JtaTE2MC9ibWkxNjBfaTJjLmMKKysrIGIvZHJpdmVycy9paW8vaW11
L2JtaTE2MC9ibWkxNjBfaTJjLmMKQEAgLTQzLDYgKzQzLDcgQEAgTU9EVUxFX0RFVklDRV9UQUJM
RShpMmMsIGJtaTE2MF9pMmNfaWQpOwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNl
X2lkIGJtaTE2MF9hY3BpX21hdGNoW10gPSB7CiAJeyJCTUkwMTYwIiwgMH0sCisJeyIxMEVDNTI4
MCIsIDB9LCAvKiBBWUEgTkVPIHRhYmxldCAqLwogCXsgfSwKIH07CiBNT0RVTEVfREVWSUNFX1RB
QkxFKGFjcGksIGJtaTE2MF9hY3BpX21hdGNoKTsK
--000000000000a1125305ce7acbd8--
