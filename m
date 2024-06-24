Return-Path: <linux-iio+bounces-6798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB02914457
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 10:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4810F28403A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD454964D;
	Mon, 24 Jun 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVG2HaFg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F639FC5;
	Mon, 24 Jun 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216901; cv=none; b=EBtRX/tJOgb7TfMMBBvTlwQ7wbDeFmgRWFqovifcRDja8kd7eWSNkIwCZYoAXhbOVjtiLa/QfgsalQb9yO0gPOgqNm+ih08HWHDzp7YYl2MHFkKvNK7s4f1RYTKE/4MFgZTvfFJwtjbjoG61Sie3de2FFw1SUVljmxpG3mH0tgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216901; c=relaxed/simple;
	bh=hRYREobyvCAzKtt5mW5IeCI5gt9AaSc20gWQ/83QMEc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8z2aiXl7dBe2JoBokw7RKNUAUXkIjWnxJxyYKS6A2BNzL4kE4pw8FL0GUUbhAS/Gef5HZWzVak7bx+zLD3njD01g8Yc35on6VBRNea8VMemupjvWYMkhXQ2R6Fun9gKfgg7g7mqXPA6yFWimF6+SSTeU35BNmydMqP1+bIhIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVG2HaFg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42138eadf64so34114205e9.3;
        Mon, 24 Jun 2024 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719216898; x=1719821698; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRYREobyvCAzKtt5mW5IeCI5gt9AaSc20gWQ/83QMEc=;
        b=XVG2HaFgPmaps4MqCmP83dOmn/900B+B34mdLJRsIqNH+Ke5f9uI4lSDfwVoyKFSPH
         JWScuB3zzB+lPRK9dMRDBVRrGRJkeI2nCyAMb/cQq4wJ+U2gUOj12iLtafXlE+f2TMfF
         OjFiTvrseceAO0c+3ApqTJEtSfPcLyuY50PeGFH6AvqVb2P0GcFnFVeyOkLiNtVB2V5Q
         W5108EZhd7h20BnPwPqYjTRYRUn2QdyMjIJL7DIc21+JF9XsB4UakBVFGBaxwtmN4C23
         NOWoQUP4Pk1wVTOELZMaVF6EKJPmB9AJkemnRQLNmaQMUIYjcemBOQbIqUFOsIG1CXc3
         7VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216898; x=1719821698;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRYREobyvCAzKtt5mW5IeCI5gt9AaSc20gWQ/83QMEc=;
        b=cTUzy4f5P5k/NgI8JCt9Lkm2Li1KiCtP7EklsPZaZHpeGtbGVJsCnZujpEoxY0QmKy
         OarefJp/yR/5S3j7WTp8wqj96dXFmTMI6g6QBg+WAE5zwrA2XFbGcXGEG0T/CE7jDSJN
         EhCM0wIu6615ofv87P0GRyIXIBr3PWgSuKrVVNt3L7xk231GqUZ/dOT06LPAFMlQHl2/
         KGJg9jQBYvoIDFdrgr5Q7nikDe3MiRKYp73R1Ssxe8ATPTGGe388iP2wUlRsk9Yyf1IH
         EiQWENfLa7tEoNxuLHiDR61xWR7/ppCMsa7Mkd5W5J/+EzxOChydhdYl2A/lx1hxNH+p
         cx5A==
X-Forwarded-Encrypted: i=1; AJvYcCV1kPtQVE77uLnHm18z6lySBsRqN0PkevsssKNb0nRhfdzbx39uIcjW8Imp2VKA3wfeLEt66QK7xLf/Fvnkprpdto5xnVNzHRxqsBxB4bAgN1ed4qNr+X63wMDhbxNxRmN4KxuXW300
X-Gm-Message-State: AOJu0YzJqpq0Qyxd+J4Jig75sMI31MN4ZjjWeGC3q4ROH0bEpbIsIDmP
	KoH11Z2LbKjxLJZTXf7AkgR3ItJbJobPVzuSei3CEwbWR5fsjWIrW38duuea
X-Google-Smtp-Source: AGHT+IEy1X+hOUJiHqA3ecZ6Ii0x22b6sHG9btRiBLKNsIPVxvEr2exgOHADZY6aAn5A9lmQazxFtA==
X-Received: by 2002:a05:600c:4c23:b0:421:7e6b:1b75 with SMTP id 5b1f17b1804b1-4248cc343a7mr27420295e9.17.1719216897914;
        Mon, 24 Jun 2024 01:14:57 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248191c65asm124398485e9.40.2024.06.24.01.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:14:57 -0700 (PDT)
Message-ID: <e3b23dc323a0ca01f3e47dde10406c81062f544c.camel@gmail.com>
Subject: Re: [PATCH 05/10] iio: adc: ltc2309: use
 devm_regulator_get_enable_read_voltage()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>,  Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 10:14:57 +0200
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-5-49e50cd0b99a@baylibre.com>
References: 
	<20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
	 <20240621-iio-regulator-refactor-round-2-v1-5-49e50cd0b99a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 17:11 -0500, David Lechner wrote:
> Use devm_regulator_get_enable_read_voltage() to simplify the code.
> Error message is changed since there is only one error return now.
> LTC2309_INTERNAL_REF_MV macro is added to make the internal reference
> voltage value self-documenting.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



