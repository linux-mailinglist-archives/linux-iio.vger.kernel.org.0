Return-Path: <linux-iio+bounces-21180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E7AAEEFB5
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 09:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED047189BE9F
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35809258CD0;
	Tue,  1 Jul 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAO8BAaH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBEF1EA6F;
	Tue,  1 Jul 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354645; cv=none; b=KeLci6bZisVbAw+1y2zzDo9AoExAL5h5m3y2t1ho/IygbbGKe1QvSYh/YIMmRsAKJkaz51XPCP95tmaVG0IBgg/n+AknXPh3wUQZCsHTWUkp4k4vP9mQAyZ7cgFG6R7KYgz+0ZUgEx3o9gb+qIrJo4S/8h9m2HxE2BSfKwampyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354645; c=relaxed/simple;
	bh=HjDtuauV+NnY+Z2hB3G2b2MUF68nvfulxc5469nqt+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHx7rgBSaKJD2f699hGK56l//ztySEYWRs8TlnAMTVkfCwTPhDvftVIU2SVBng7H1nx5uXIs3VPhwjfJ+HLF0k6tC6wMl2de4A4ML3Edy19Yw3VcuvGkGourLAhUvDHTl9AtKff7aY7G5MYI/RBfVUNumci8qk+ru0xqyxkjhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAO8BAaH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7152d8c5602so934697b3.3;
        Tue, 01 Jul 2025 00:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751354642; x=1751959442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PD1ojVs/o5EGP3bpZItqlANn0Caes40vz6lO01Z9vf8=;
        b=RAO8BAaHaTlSr5M/pNuP3SltTOw10ueLiGEAaNQ4I1TP5XUnLPx/ZLDDZfusxCKKRv
         gMktOxmn724RywcqbIY4Ycfv+brYn6Hxib/ILeSt7xOyYcR7PL0TWz8Q8hIeZYUHYdR5
         J+YLxxul/NbwB8I8IxQpGx0W7sNc7VKka/I5XcUShPelPTl3zvJUKRyK4/RQhAm7+Uj8
         lOP9cXnX8BsRTzyFhDreTsesiQH5vD0x7kZc1NUd/NW8y1Vw0vSGXBvg6RrqU/lp8ku3
         vAC7eoOFzjqwA6vhJSs3Xgo4P0yee3amOEL6AJUUh4OS2f0ReT0IEcdb1LKgxHareOVH
         6faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751354642; x=1751959442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PD1ojVs/o5EGP3bpZItqlANn0Caes40vz6lO01Z9vf8=;
        b=I798922YRrUAob9lw/cWdqAhOZrOwEI6OFHCH3T+djCIK9dkcUpvwS+YkY/SnqppkV
         gtBhrgE3wX4KqLQcryoPBCC5NOTNLxtv1tXUtqRdxeV7d+aaZbeR6nAUlpG43aGET1ID
         Z2Mod+3iBnQHxIVEt89zvorp3WJo9EVFS5JmtWP0VIZfmB3lzAuDE7cWQUyc6F2nUBND
         tel3dWM2DCWqnYTAt73HKjBXvBojOva0aQS9s7URF7DhSA0WZVaotZfPiVYKAUvhLQ03
         43EkL4leU42IffHVUaIL4RG3PVqjIIC/JP+GLzXFnChmXkiqhS1z75gh9zSkTNCN07Xw
         8teQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyTB8VWvqdT0nsHsDJ40h/xVgs6g+wrIyRrVa2PrqEOI6MII6v24qOot+NXjTxZrryIHtuBeqCzMJB0O6d@vger.kernel.org, AJvYcCW6FcDrfcpoHQPwbArdIa7O02lyqx98l3PX8WCmCF3xUvNUcBgdTAOMh6wtwsRqhlxrR5h5DPOpwe4l@vger.kernel.org, AJvYcCWzABLWIdbZza11WyGWGBg3RCGXCAOAsWPZXpMhznS8nhBWukw9q3anDWiPVAIZE9cXd9h5wI/XQjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8mqfLSSyPqPrM1hHf4114ZGpsMJGmUGPVy5+8SvOCctQlM8i
	vdRYcR/2+4A0OsJWrE61ve8Z7eU54ut1JxRi/H4LiaRgMwIpXTfmaqIhj5RKnincXZFjYy/LK/1
	AThKeJhGU8qcwmI5LJ03vaqsKBbwu2YU=
X-Gm-Gg: ASbGnctPxBmlrRBcpufvMzyf7e/pEo5d18+dA/M9syQcpF2OKraNNgRrJhiQxbUQ5kC
	/lbw7SmbHdt63EoKSnnw6+tQb1thwK1rY61BNgxlOItQyaOqFi8+Mm4kEW5o2pykftVbeaR1gJL
	yytrRTsIUtjXAgo5Eh5ZNQLyxxQRT+DvIvQmhoxzEZwiU=
X-Google-Smtp-Source: AGHT+IF9Zs+xVGv7NWWeAGJEQldTJ/+ArWtLpje4jFNAtPBQW1QmDtdZ/TG5sZniRJkBIdKlz8QjDtHJ1iVcsohX168=
X-Received: by 2002:a05:690c:dc6:b0:70f:7bea:5dd with SMTP id
 00721157ae682-7163f7a475bmr13322897b3.9.1751354642320; Tue, 01 Jul 2025
 00:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622122937.156930-1-l.rubusch@gmail.com> <20250622122937.156930-4-l.rubusch@gmail.com>
 <20250628181643.0ce0ed51@jic23-huawei>
In-Reply-To: <20250628181643.0ce0ed51@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 1 Jul 2025 09:23:26 +0200
X-Gm-Features: Ac12FXyuIYmL7BOfvP9uigNF6Ur5ogoR_YGPM0_xQgtI48zhiu_X1NSTPSUUk-w
Message-ID: <CAFXKEHYS2rRYtPShU-yyEetQQoo+EbCscjUUGcWdWJQA2UwiYA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] iio: accel: adxl313: add buffered FIFO watermark
 with interrupt handling
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 7:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 22 Jun 2025 12:29:32 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Cover the following tasks:
> > - Add scan_mask and scan_index to the IIO channel configuration. The
> > scan_index sets up buffer usage. According to the datasheet, the ADXL31=
3
> > uses a 13-bit wide data field in full-resolution mode. Set the
> > signedness, number of storage bits, and endianness accordingly.
> >
> > - Parse the devicetree for an optional interrupt line and configure the
> > interrupt mapping based on its presence. If no interrupt line is
> > specified, keep the FIFO in bypass mode as currently implemented.
> >
> > - Set up the interrupt handler. Add register access to detect and
> > evaluate interrupts. Implement functions to clear status registers and
> > reset the FIFO.
> >
> > - Implement FIFO watermark configuration and handling. Allow the
> > watermark level to be set, evaluate the corresponding interrupt, read
> > the FIFO contents, and push the data to the IIO channel.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar,
>

Hi Jonathan, there's still one thing about this patch [PATCH v6 3/8],
I wanted to address:

        struct mutex    lock; /* lock to protect transf_buf */
+       u8 watermark;
        __le16          transf_buf __aligned(IIO_DMA_MINALIGN);
+       __le16          fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
 };

Is this correct usage of the IIO_DMA_MINALIGN? My intention here is to
have transf_buf and fifo_buf[...] aligned with the IIO_DMA_MINALIGN.

Sorry, I should have asked this earlier. I saw the sensor operating,
but I'm unsure if perhaps DMA usage is setup correctly. Perhaps you
could drop me a line of feedback here?

Best,
L

