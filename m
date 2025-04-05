Return-Path: <linux-iio+bounces-17633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895BA7C96E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 15:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED5C189713A
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260391EDA0F;
	Sat,  5 Apr 2025 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD+XYm7Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D12E62CA;
	Sat,  5 Apr 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743860878; cv=none; b=OFFfF3kNdzbwSA+CEM+SAD0T9qBiDi5paB4VJVI3dBfCHxMnlxr+rVqVztjopSI4XBjXxISrqsRwDpLSSW+Orp8qo1iLZm5sOiX9OeqTdcSeLJlZZltAIyzLxF3VhclWM796JmOt8jbD55KzGCctTvwESJWda53GP2iKOArPZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743860878; c=relaxed/simple;
	bh=R3SS/7aKzngxLnEPEAm3IeSAEnjCHF6zNAkjT/gnKk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAnG181NDSKCPAKciXAjNRneKiLrYXd96xA1NcI0CVYINXBLUVoM7QLHAefgicHNDhm+KEb8D9Zshkvi5yozVqtIVWUQ23McLr4BQ6u/zdoDOTHmxcz+00SGes43HWf/GdO5DG+Ngn9gxbDTNEmkNbXHvFMWAFOZTyzTOsYTgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD+XYm7Z; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-afc857702d1so784012a12.3;
        Sat, 05 Apr 2025 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743860877; x=1744465677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzKfVOqqIvV0aKanDKbv6KWJG/SxwneBexDSwiQq5Bc=;
        b=RD+XYm7Zz/focjUfZL9LtSyKJSzUb3fDIWAKxCO96TXIsawvHfTEAu1GZQMazoqWrA
         X457jci0buyQf64hOfV8Akl+avaM+RDCoHt2YsgBeWoMEkaW+YD5JJomolNu1QIdWmCS
         ElVp04clda7VlyQeWMtVw2CI5Hk2jPq2mp6u/O2kc45pidXGBD+ZpkW88UY5a8+y/Blw
         DxNg11sYlSYYIlsaiHikNNjaxOTz3N46OWpyYxfuFDSRG4iqd3IreszXj+2xcehLlOXX
         MHXh+9bGac4J5YXoPZuW3MoqL+8rjLZAe9RI/WO+m3l9YOqRZVGX02zVqtdeiV+O8TFl
         NtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743860877; x=1744465677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzKfVOqqIvV0aKanDKbv6KWJG/SxwneBexDSwiQq5Bc=;
        b=Wm3Bh6t+8vDRphfqr/fE4SMhh6/ep0OuVVVmsNZ76v58Dheaf26BVso/tP8mIAClsv
         WID25ajBbBV+8YZ6UQ9Vi66ouqtr/krDJlHtcw63wbf9snSsCEKilRZTmGcSqYHZ77gT
         Ys1A65+/HTXLlc6nVxSnW1ImNOn34Yv1ezUwDDd2SkYXZasfabssGzV1rG0m8LFq6Qp+
         MmXWmfDt8959VNtIK5L5n+GVUT6VxfKzNo6wxK+q0zs4L18NuwVhFZl9xX1sBOrrvQi1
         dEiNkk577gSFuiQo/qjxCnFODgk0GojwKySkwJIjBJqmaoCuoUUCdzcD5w7QjsmnBg4W
         fnvg==
X-Forwarded-Encrypted: i=1; AJvYcCVAJXS/W5VPizHLMwdtaOTkVRBRVQfoIIFKJl68fAtNVuQwX3NYnqjdnsaW5mRHR8JEvrpvM3JJcM3p@vger.kernel.org, AJvYcCVbRh0TI7ek8UIoU3l3vFHOKVuwWqayTY4JbxyYJ9JeCp699MFKr1/AgXT1ZIA4wJR+wfKxLX+ne3Xs@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAPQqII9nHZi3/bRCTfp9WO7WM9MqfitahXyDUCHCB7eBeig6
	R7E8wqkPXwC5lAC1lABtFDLl9IP7lCw4i4weYVYQBy1oryKcyAGotnjlE26k282HUruIeWbQ3cR
	57YzIZX/LqjyY9W+OkosYbB5vC9Y=
X-Gm-Gg: ASbGnctRyxsklWu7TNJuU9H3iH5f1v/b2xPQbrRZHskeB5AtOMcvXQdwi+/yke75Cd6
	oKu4F3RXHrpywdIRKilYluo42Ywiw3ETHMHsKrzV8w4JbBsxvL2OhUSKqmpFUWhcXor2iJvSJqu
	6OYBp1kiGHIlpzFhXr2ZBpI/GlPcY=
X-Google-Smtp-Source: AGHT+IFxjIKOj7rBO2LZ+V990HxR8M+mx19eZnkrf+6BFl9L+5CYDRa6VyginUxntHqxmYkK+iY29c1Vuu2PVCqShxU=
X-Received: by 2002:a17:90b:524b:b0:305:2d28:c8fd with SMTP id
 98e67ed59e1d1-306af7b825dmr4055719a91.24.1743860876798; Sat, 05 Apr 2025
 06:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403053225.298308-1-gye976@gmail.com> <20250403053225.298308-4-gye976@gmail.com>
 <20250404123308.00003d72@huawei.com>
In-Reply-To: <20250404123308.00003d72@huawei.com>
From: gyeyoung <gye976@gmail.com>
Date: Sat, 5 Apr 2025 22:47:45 +0900
X-Gm-Features: ATxdqUFQIKzNIA-1SGYiCnMzXS2djdZHfOrCwY-ILBi5fZNGkcj__QhKgjC5J6k
Message-ID: <CAKbEznsozpnfFgy3Giamv3XJvf_XqPQ8ZF3TSZHPGfQhm+baFA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	lars@metafoo.de, gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan, thank you for the review.

> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b b/=
Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > new file mode 100644
> > index 000000000000..6cdfd34be016
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > @@ -0,0 +1,7 @@
> > +What:                /sys/bus/iio/devices/co2_range
> > +Date:                April 2025
> > +KernelVersion:       6.14
> > +Contact:     Gyeyoung Baek <gye976@gmail.com>
> > +Description:
> > +             Writing a value adjust maximum measurable PPM.
> > +             should be 2000 or 5000.
>
> I haven't checked but assume this also results in a scaling of the
> measure _raw values?  If so the control should be via the standard
> ABI scale.  If you need to be able to establish the range, provide
> the _available for the _raw via the read_avail() callback and setting
> appropriate bit in info_mask_separate_available
>

In this device, changing the measurement range does not affect the
unit or scaling.
As far as I know, increasing the range just leads to a decrease in accuracy=
.

> General rule is don't introduce new ABI unless it is impossible to
> provide the same information via existing interfaces.  The decision
> to use scale rather than range info to control channel scaling was
> made a very long time ago and having a mixture of the two would
> make for very complex userspace code.

I=E2=80=99ve reviewed the sysfs-bus-iio documentation, I think there is
no suitable interface for this case. So I'll drop this option.

Thanks,
Gyeyoung

