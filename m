Return-Path: <linux-iio+bounces-8217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D9D946A91
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 18:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DCA281AF6
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675841755C;
	Sat,  3 Aug 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb1M4UGT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE1F9F5;
	Sat,  3 Aug 2024 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704296; cv=none; b=sS0KYZO4N2RvrQphOFLagKnFunLP55R+AToSrThWVxGXO9AAcsIIuOP9XLV+zpIHyxqV28SGQ4bWG2x+L5HcOFM6G+zcNGR9erJLhcviSpfoXidGQMATXMhY1YVBtkPm2nRQLOMOjJY/KQplE8aVThA6J6lyKWjC0/2GlfJ64v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704296; c=relaxed/simple;
	bh=sGFFvNfHs3JL/qD1q2wgipRTqVRJgAkRPePKPqH/U38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFpesxOujOO1wmTMQU3EGJZeu/sPBRfVS6ur6S6n4f2Vb3VPcbGbP72tH2yd5UWC8fwTBrQNOqg3MRFq77Y66npv7MMdEqNdpkYKsfiFRdktzEVwOeLQJEysPpu6wZVa9tGxTEyRWgIS3fLxgzp/RN85Qm7204WZGsCv3KFHtv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb1M4UGT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso102011561fa.3;
        Sat, 03 Aug 2024 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722704293; x=1723309093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8INI6j3nrRiNaoBn8GD9i5uUgg8Nnq6vPeQ1KB6So5g=;
        b=Gb1M4UGTN63X71yku423BZTFi0IBezQUwdfoWKQ3zKVUBko75JmcxmkzKdb7pwtGTb
         YwG72i95bO/6Lya/0amnVSDcc9QwpuvZxTx0FtmmDgsAy+SfvV3RQbdYg+6H4G8de4rL
         qYEDbnHcwpgxj3YhB6YX2/B0mM/Zyi04FZEChR37AgwBTSwc0DC/7CWxACXaIp6De5Hq
         UxOgYOPz/ifC5xheoZ6vS92+crYsYE45cG7pmLkVncta25JLABnUth7D4bYZcz9CGXky
         n6luRD+VhSqqKwc7BQcEwwZ5J+HtlQoF9vRunAqqaBV6hmAITaafioewhJUBQJbqqSVZ
         Oa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722704293; x=1723309093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8INI6j3nrRiNaoBn8GD9i5uUgg8Nnq6vPeQ1KB6So5g=;
        b=QHcewp27TY7gz4wtGIrviD0DhKbCShO+vKid6457w+O4HRiaTbrUA51sg6g13ghBYj
         sy415IsDVaSQLSFNfpm/Wwtp0PBquXqWOzRxhr8RajNnlNlyZS3YGcUPkdPQFawAtT3T
         n3CZPG33lWK7KNXGlzphgcsI0AV49NWNVUnqrjdgam7mVk6h03JC/4k9gDfak2DLYkrH
         MkNtOLyNuJtkYajGlRs2BP4qq46rwlSxWeH7AbMyyYc83qtFcEZfb2gkpkis6Mo+f72V
         56YIzpllnENajZ7a7IfPfgJS59z9ZOHn67+knQmH2PWLEDEE1BIzM9vgeEMZ0LnMqP8p
         UriA==
X-Forwarded-Encrypted: i=1; AJvYcCVGtCXAsPxo3UwzR4fL8AhxrAEZMZJlk+ybDRNt9+nHRUDbhf0cZKIYsDooMI3w/KZrX3V3awYZLMcXWZSkW+jPzLTyUHC1rvti6YvE
X-Gm-Message-State: AOJu0YxeXJMcSZQ/RsE1qcagoXq4vDwnMi1CUpIVFcO46fI8difPC/ai
	iLucVsSP1htCPvr0pACE+hKEgj8cIiVt2lQo9h00fgXHVbYC8GIuKBf8c78qovob/sw7e0MvLPN
	vOlvBdqd7wybEkvsY0NRjnU4ejwk=
X-Google-Smtp-Source: AGHT+IG7VSBHtWJx+t8T4A2RnHF1oXmkNIZQ1q+Y6uKpkYnf0ljkTOSjL2/0Ll24Gc2RQSAC+V05rbuX+ehcpZkJQeI=
X-Received: by 2002:a05:651c:1a2c:b0:2f1:5c51:41ab with SMTP id
 38308e7fff4ca-2f15c5142f4mr50301051fa.47.1722704292188; Sat, 03 Aug 2024
 09:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com> <20240803145956.2562ad71@jic23-huawei>
In-Reply-To: <20240803145956.2562ad71@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 3 Aug 2024 22:28:00 +0530
Message-ID: <CAG=0Rq+q0WJzMroYwQy-4Ng0aSkTvaw-FEMx68i3MqAZwfteCg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Replaced IIO_INTENSITY channel with IIO_LIGHT
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 7:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Wed, 31 Jul 2024 12:07:02 +0530
> Abhash Jha <abhashkumarjha123@gmail.com> wrote:
>
> > Hello,
> >
> Don't change the cover letter title between versions.
> It makes them hard to track.  That title should not reflect changes
> form previous version and it should always tell us which driver
> the modifications are being made to!
>
Thanks, I will make sure of this from now on.

