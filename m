Return-Path: <linux-iio+bounces-22930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AC1B2ADD4
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F7A3AF9FD
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17512326D50;
	Mon, 18 Aug 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOFcLOEB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC893203B0;
	Mon, 18 Aug 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533483; cv=none; b=gbtr19AyvUF4SQR6Zjo/pRGum3OMTtUV7rBiAFUfZIp8wrTj7+NKqnnw6cKOMlIIZPMWJBP+WjE4WLqAw6Dp9LXPisPdN4C816tJYG3G5sXe4OzCzk0ZyTyomJA/vl8B3FwAKEFAoXI9SaMcDrReVo5pO1jFNeFQ0LyLakACScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533483; c=relaxed/simple;
	bh=pyQRwWEObJuHvr9ty8xXMUnJrmo5nvSMXaHj+3kqbw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EW8keMbkNo7WJbudq8rVa4ozVVtp8QdfU7rZRRLeG9HTQUwHDPRFnnYOTbsf9Q42++q+qrx+CAyXU0qUBsSusbhuTkr2r+Hc7AAOAdcQ4UjcRdRxCubFJCsWU27pUqd2Gv9Zc7XFCf9kPRMlypdRGWPACC3x7nVefgs1iAIeq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOFcLOEB; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7438175d42aso2677583a34.1;
        Mon, 18 Aug 2025 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755533481; x=1756138281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVMUYwe5tHhDclXcSvK/OoInVyX1p4cYa0l7+9pr+2k=;
        b=JOFcLOEB3PrEG8YbAvOL8p44oaQzdy0DhP66lg0UBZJ+qFccD676X4fIdCJBtN3AwM
         2Vf/1H/Da9VnS9xvG1s1U71SV/xb1LItWWG4uzPrci/FQX1QNMW7Rdasg97BJBmbmnmI
         3fsXlP4pPF4ubCDCVBinGWmd/MvsP0q9XKNEHYbFzRiLwBprpUJpJaiUqwWC5ibYXhI1
         WvBaxZRE7OHvfK4vrlu3j9Y8H+YPJoz3NdXVB7CqytcyQ/4a6+demldZ1Q14WPVwRXcq
         1wqC4g2LZ1FkOer9Y7maVDwz/bz8Mh0V7xjme7Jo8ifcguPMjsVrwBPe9iWKG+OvLqaK
         2w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533481; x=1756138281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVMUYwe5tHhDclXcSvK/OoInVyX1p4cYa0l7+9pr+2k=;
        b=Y3d+agYiClY14cAkAKHL3qmvOK/8slNb4M+dstmO+H2GhXiSeNsCmTHmaFL6ocJh2G
         JtAS5Q9gFyw/1Bsswi4lsOuBrdTp/3A/gMkxxl5Tbeb5fJyMKxazhe09jCuYZN3RfC6X
         zio+3R+10Kor9yU1JjmwVnTxjAj+3Ylyo4XQ0J6o3oZkqNMHcvQ9gz/AwyDJOIA7/BT+
         8qWrX5LID4+ejGUgmBxbg5zqM1k/6RZoJggWYp4jzOVnSCEbyOus21t0/X85ZbMnWyr2
         NF62k4tw+nXqlDDwPrcwNv3P3xIpjdU4niQWUlR1zg7sH3hAGIm74JgmsfPhmaAAmCj0
         ObkA==
X-Forwarded-Encrypted: i=1; AJvYcCUNI8NFAkPnTomASBSrE8O3RH7WXaYKUGQrpdLLQze3+83avbRbqlQo+slaKPWiuiLVncwcJ+UZfK6x@vger.kernel.org, AJvYcCUee2XwUVhEvOujmOwgdprHBGNHhU2eUtHawY9lWwmFrZL+Cfoctl6Ni7bpnvy0nmCh+GRQDyETIjdh@vger.kernel.org, AJvYcCUxBVileoz6OaEot0uZKXpjKOGwRtdgXO+wREWmy3gPJNEwoIS7myw8Tz9ht3IFNL/i4ILuGkmaHu32AoWF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxh/e4+L+dIba6A47nN5divn4xi9hD9cndSWNBju6N3lzCge4H
	XpBt7j0qMW5i2JfpSCE9TagohClOANFfz9bk0XPJ9oXQJYEhVFDnswmHgo5JnGL7QadIWeN3Zf0
	26vmQvgE2XMzAEdNofGhzdeZWnRMhCR0=
X-Gm-Gg: ASbGncvGSqlXIF3sikrSLOqGD9b2uXLMwynsiiI7xFnFt1awq8eYG5huOmPONegS0Jv
	JRJOFbduD1GivV6oN4Cmz+XoyaPcHR0IxpCumBtcnzz1Z2yCL3GZ6dWjAD3/ZuufdYcLktYgxjA
	HD5hcdE+zGIUNWPLmxeqf/cnnr7Ewtq6Go+ecG7vFtg+SKK2HeDTQQTjrvJsLPSI+rCcb1k926U
	4A+Gxlm9A==
X-Google-Smtp-Source: AGHT+IH1nWR4P3RblHYTY/yamzarKnJLPoqzR+Fate6NXmOw4iYB85bdAFBy0VflTuqaJyyCfs7H/68kiB7cq8VC2aE=
X-Received: by 2002:a05:6830:1201:b0:73e:9fea:f2a5 with SMTP id
 46e09a7af769-744df036b12mr110871a34.4.1755533481065; Mon, 18 Aug 2025
 09:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com> <20250816111855.7e934f4d@jic23-huawei>
In-Reply-To: <20250816111855.7e934f4d@jic23-huawei>
From: Alper Bilgin <y.alperbilgin@gmail.com>
Date: Mon, 18 Aug 2025 18:11:09 +0200
X-Gm-Features: Ac12FXzQTFQattZe625ZGzNR7DODPUn-uR4-1v7Ba64mu7PW0JdDtp_v2P06sRg
Message-ID: <CAGgmJFsqfo4ddGdgDaPg4BRkYjQfn25wo0yrf1tB2f8g9L6aEw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add LTC2495 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thank you for this guidance on the review process, that makes perfect
sense. I will wait longer for feedback on future versions and
contributions.

Best regards,

Alper

On Sat, Aug 16, 2025 at 12:19=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 15 Aug 2025 12:02:01 +0200
> Yusuf Alper Bilgin <y.alperbilgin@gmail.com> wrote:
>
> > Hi All,
> >
> > This is the v4 of the patch series to add support for the LTC2495 ADC
> > and to enable the internal temperature channel for the LTC2495 and
> > LTC2499.
> >
> > Thanks to Andy Shevchenko for his helpful reviews on earlier versions,
> > and to David Lechner and Krzysztof Kozlowski for their feedbacks on
> > v3. This version addresses all feedback from v3.
> >
> > Best Regards,
> >
> > Alper
>
> Hi Alper,
>
> A small process thing.  Wait a little longer between versions
> as it tends to save time for both the submitter and reviewers.
>
> At least a few days is appropriate typically and for first versions
> I'd generally advise a week. Many reviewers only get to the list
> once a week or so (some less than that!)
>
> Thanks,
>
> Jonathan
>
> >
> > Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
> > ---
> > Changes in v4:
> >   - Removed the verbose formula derivation comment from `read_raw`.
> >   - Reworked the temperature channel definition to omit the redundant
> >     `.address` and `.channel` fields.
> >   - Moved I2C-specific bit definitions from the shared header into
> >     `ltc2497.c` and removed the pre-combined command macro.
> >   - Simplified I2C logic to check the channel type instead of a
> >     non-standard address.
> >   - Combined the basic device support (#2) and temperature sensor featu=
re (#3)
> >     patches into a single patch (#2).
> >   - Link to v3: https://lore.kernel.org/r/20250814-ltc2495-v3-0-c2a6cec=
d6b99@gmail.com
> >
> > Changes in v3:
> >   - Used the standard `kelvin_to_celsius()` helper instead of a custom
> >     define.
> >   - Corrected macro definition style.
> >   - Renamed `LTC2497_CHANNELS` and `LTC_T_CHAN` for clarity.
> >   - Combined all struct layout optimizations into a single patch.
> >   - Link to v2: https://lore.kernel.org/r/20250813-ltc2495-v2-0-bbaf20f=
6ba07@gmail.com
> >
> > Changes in v2:
> >   - Rewrote all commit messages to use the imperative mood.
> >   - Added a justification for the new compatible string to the device
> >     tree binding commit message.
> >   - Removed all unrelated whitespace and formatting changes.
> >   - Removed redundant explicit `false` initializers from structs.
> >   - Replaced the magic number for Kelvin conversion with a define.
> >   - Improved comments for defines and temperature scaling constants.
> >   - Renamed confusing macros and struct fields to be more descriptive.
> >   - Replaced dynamic channel allocation with a static array approach
> >     using a shared macro to improve readability.
> >   - Optimized data structure layouts based on pahole output to remove
> >     memory holes.
> >   - Link to v1: https://lore.kernel.org/r/20250812-ltc2495-v1-0-7bf4c6f=
eec2e@gmail.com
> > ---
> > Implementation Notes
> >  - checkpatch warning: The new static array approach uses a shared macr=
o
> >    for the common channels (`LTC2497_CHANNELS`), which triggers a
> >    checkpatch.pl warning: "Macros with complex values should be enclose=
d
> >    in parentheses". However, this will cause a compilitaion error, as a=
n
> >    initializer list cannot be parenthesized.
> >  - uV to mV conversion: I could not find a standard macro, so a manual
> >    division is used for now. This could be a point of future
> >    improvement.
> >
> > ---
> > Yusuf Alper Bilgin (3):
> >       dt-bindings: iio: adc: ltc2497: add lltc,ltc2495 bindings
> >       iio: adc: ltc2497: add support for LTC2495
> >       iio: adc: ltc2497: reorder struct members to fix memory holes
> >
> >  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   3 +
> >  drivers/iio/adc/ltc2497-core.c                     | 132 +++++++++++++=
+-------
> >  drivers/iio/adc/ltc2497.c                          |  39 +++++-
> >  drivers/iio/adc/ltc2497.h                          |  19 ++-
> >  4 files changed, 147 insertions(+), 46 deletions(-)
> > ---
> > base-commit: acbbb5a20971089064ca6b271dd251e629be8d4d
> > change-id: 20250811-ltc2495-572817c13fd3
> >
> > Best regards,
>

