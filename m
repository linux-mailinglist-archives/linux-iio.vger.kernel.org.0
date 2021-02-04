Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76D930F96C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbhBDRSs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbhBDRSg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 12:18:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53931C061786
        for <linux-iio@vger.kernel.org>; Thu,  4 Feb 2021 09:17:56 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a12so5726543lfb.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Feb 2021 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mW0S80RSk0Fj8h6CzAJD4WEo4AGXylGSIuy8/JomB6w=;
        b=JRO7iBdaS2icVr8dI7csWlq7vfvRcu9Xo1LGPltZLzblJaqeOTcTX88hOfEBRa29HG
         GecDA0pqEJS9h8/1LoaZGln4gYXnZAYlDX8QxR0NxSUqcTcUbUENuYjWYqk4pgS+wFNH
         N43q/Zp/VAAtg/9ZLYtWso+SAVyfSIrm/XpQf1MqYHjSqM8ZcW7uaNLgD3q4tYT+qeiF
         clsaOr5+PADeSUguqw0fBnteWoorn8385RYQqT+Mj6/fy+u0oIONzysEvXGDq0R0Atvt
         kApJ0ImXpQg/o3IM2isLuNYEtouAFN8UBdAPZl50shP30ETlYiP4xQjdpc/FzfKJV2Sc
         AQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW0S80RSk0Fj8h6CzAJD4WEo4AGXylGSIuy8/JomB6w=;
        b=iv7gkDiZxzj2UG29ulHa9i5lXYVuaoFDk62RhlaiGqi/b4grSx1piJ33u05u0fqDCQ
         MbWGZGXviVMKcDlbrI7C+v1RY0Zrkh+Dt59ZgwIehKFt2kFVDuRVd2l4fi4T83Mgofrz
         A0+lQjBvyO/Nk1M3656qMljVAnHUwEhHxIUR/Ubam12nFt35cp/ZmUCaHLG5RjcWMl8y
         J0rVnwKI00XMrgJrYF1/wmpHBNVZSvG5A2ZUdfsXvJ5ZgRDnc2EQZXbZverNVz2+eGbZ
         5WNVqO3TwMy1SaEz1wOgQH2M63bhwvBc3vvt/+6i0a2C9L0hnTHfR1c1mx+ChoM2bTZb
         2N9A==
X-Gm-Message-State: AOAM532hfOwkptEAwLjq+iRzYxb1e2kbc5SJTUg6dIV7sCVhraeQ4n+9
        JSAr/qlWpYu7Tmro1tJwoVu1qy+9WGb7e2q3NEZpeHNVCv2dNUFN
X-Google-Smtp-Source: ABdhPJxcfrqCnXhPLAm5cYiY4WG9eG6j/kzsIQoT27w8fNSPJF+SncKRJFiRrIRqNOCjqI7gXP5K2G0vmX8E/viVlJY=
X-Received: by 2002:a19:6d07:: with SMTP id i7mr231133lfc.75.1612459074926;
 Thu, 04 Feb 2021 09:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20210204155430.GA557111@ubuntu> <YBwcv8SkGBmrq+ck@kroah.com>
In-Reply-To: <YBwcv8SkGBmrq+ck@kroah.com>
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
Date:   Thu, 4 Feb 2021 18:17:46 +0100
Message-ID: <CAMwq6HiFcW2niGaVhUOWiomXh1_HKw_2x37_mjMLcXPHEDhb1A@mail.gmail.com>
Subject: Re: [PATCH] Correct bit mask for ADC result according to ADC's resolution.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 4, 2021 at 5:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 04, 2021 at 04:54:30PM +0100, Wilfried Wessner wrote:
> > Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
>
> I know I can't take patches without any changelog text :(
>
Sorry, it's my first submitted patch, but what exactly do you mean by
"changelog text"?

Soemthing like:
"This patch fixes a wrong result mask, which was caused by an improper
 usage of the GENMASK macro.
The GENMASK macro indexing is zero based, so if the ADC-result is
right aligned stored in an integer based type, the mask
goes from [resolution -1 , 0]."

Thank you for your help!

Best regards,
Willi
