Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E92120935
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfLPPCr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 10:02:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37552 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfLPPCq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2019 10:02:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id u17so7166750lja.4;
        Mon, 16 Dec 2019 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zUUr1fG3xEuWKKW5t9OnMBrPgODppeeCh9UkxMRRg1c=;
        b=ut8EkHmdreDv7agrK5b9sBc9nmef6QACxq02foZ9iEUwmkMQZWnEpeLjaRddXJ5gcY
         mRBYuQ7IGb7HYambpnOwIyocYa5fYbR8p20iYW+kUl1zJLBSP6LGJFGqtT0DwUnTVsvp
         rktrBgqgAjavYFNjrUjYTzi3s76d8h1wEn9rmVy5FT6gGmhp9Kf31VPwCAtmwddDdBkV
         Fn8rZ6KyPhw8j/AaHU0QyvilMDZTrkcMI4yLBuqNCcUDXEKYOT/0wyyPMo5qwOoPJYMQ
         mXw/Dxow9dMxuPtNj4wW7pjhSoJlzDux1cWmnia5nz8FVlHRc+a2Jnqt028D0n3O2xGi
         jt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=zUUr1fG3xEuWKKW5t9OnMBrPgODppeeCh9UkxMRRg1c=;
        b=Xw/2ZNp05FxjtfwpY2gR/IouHlJEiIWl0hTa6Wbzlv4dlyor4cjFXKr/HpGK3YYZty
         Xrm9oMA/d4hvxJK2kt2EVq9+qCV6MVSRoTVVlN7jtx1PLb8xV95giLSZuxTZTbftSle2
         kXFSoO3ujJ75AHLBMGrv2bhf9Ah6r8jM7rqubbgNq9NuJyjYI02R2I/XrJRBtGctifDa
         z7c/7UdKkpo2eDtn3WTEryI2ufeTL3r8Q7fL3IxnYuaxC6k4fHsB0j+gQ/poIFd0aDnv
         6kv404buFn/F6z3ToIkDfEgkNd3Nb28prOaRDEW2S06zNMEWaKV95F5oe4hKSzGF9v3B
         QWQg==
X-Gm-Message-State: APjAAAWTGSZAnQp02MaPTkq/ryzYZUJhdMMzx23j7XgNj4spG4NGocch
        FXfqTHAWbp3zzRc2el6mmAQWskdz1YaUq6DFhIuK2NftCds=
X-Google-Smtp-Source: APXvYqzc0wEJbZ7G36zOsrHJBThcbUlDuyW5JWdridpwfRBGfsP8BBeBY7etAdaUybqG2hVjAfanp/s4TuEHqKFelsw=
X-Received: by 2002:a2e:556:: with SMTP id 83mr20318081ljf.127.1576508564435;
 Mon, 16 Dec 2019 07:02:44 -0800 (PST)
MIME-Version: 1.0
References: <mailman.18297.1576387017.2486.linux-nvme@lists.infradead.org> <20191216032540.GY32169@bombadil.infradead.org>
In-Reply-To: <20191216032540.GY32169@bombadil.infradead.org>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 17 Dec 2019 00:02:32 +0900
Message-ID: <CAC5umyiZGzu3h9tUrSRWh6c6WLyUvXtdDvThw+VHoTjffBVNZA@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] add helpers for kelvin to/from Celsius conversion
To:     Matthew Wilcox <willy@infradead.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

2019=E5=B9=B412=E6=9C=8816=E6=97=A5(=E6=9C=88) 12:25 Matthew Wilcox <willy@=
infradead.org>:
>
> > +static inline long milli_kelvin_to_millicelsius(long t)
> > +{
> > +     return t + ABSOLUTE_ZERO_MILLICELSIUS;
> > +}
>
> Why is there an underscore between 'milli' and 'kelvin', but not between
> 'milli' and 'celsius'?

Because these function names are derived from the existing macros in
linux/thermal.h.

Does anyone have a preference for the underscore in these function names?

1. underscore between unit prefix and 'kelvin,
   no underscore between unit prefix and 'celsius'
   (e.g. milli_kelvin_to_millicelsius, deci_kelvin_to_millicelsius, ...)

2. underscore between unit prefix and 'kelvin,
   underscore between unit prefix and 'celsius'
   (e.g. milli_kelvin_to_milli_celsius, deci_kelvin_to_milli_celsius, ...)

3. no underscore between unit prefix and 'kelvin,
   no underscore between unit prefix and 'celsius'
   (e.g. millikelvin_to_millicelsius, decikelvin_to_millicelsius, ...)
