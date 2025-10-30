Return-Path: <linux-iio+bounces-25691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75046C2159F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6D7B4F32D0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D23322C60;
	Thu, 30 Oct 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZf5k1X9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60E315777
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843504; cv=none; b=BxkzY0tOJHarqd1arMsqCaB0v/rKEHO1vcYOuw0jDfhDdxmOeVyFLyD7pf8raGmJwCRTY+NsdOMzktRgVLbcO1tGS4zasU/tH8FSpTegek2uU69osDHfzPAw+3D0EegvN+gfYSF3b3xq9XtCBgiXHLPDDReb55acQ3ZIZAdOb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843504; c=relaxed/simple;
	bh=E68T2ZkjnQfOB2TtPtritiOjh/qgxTXRIYSNsvI6CzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUKo/RFq71IDZMf7/eafhWplNq4eO2EAaf+tzH0y0QIkloQDx32nFsoLwgkaVmqKE08DEUNQtNXrfmNDUCojJuAJo1I8j9+RAi73ocef0GQnyYTpIjdGHERiHnDW8gyAKKEQROICJha69Vnk5y7zseNRca6DiRNlHzJL16pDHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZf5k1X9; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63d0692136bso1665103d50.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843502; x=1762448302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E68T2ZkjnQfOB2TtPtritiOjh/qgxTXRIYSNsvI6CzQ=;
        b=KZf5k1X9bxs1cxIK23l+w9I/oMmpg0XjlJPmml2dLDopGrLZWiUSajApfBzYUDLq+o
         X7dGwaf1kKx+3g45IIlwl4OGqtlwWrT1X6BNWbjiAN6WzO/IKdDcIG5eCtB2kb5Q6CfT
         8i/S+dZFFOUOUdiK2nnpKhlfdPFOr86FmjPYct5VYt8dqRbJcbFhj6sAz0oVMMhJu3ya
         NeLfqkL5T3v3Rity4jEnonwBOYOUkIuEGm8DWmZnU/qOdb6m3hZQJ/m+PSFpl+KAnoaZ
         KA4GAz4vNNfJoYEnW7MaVqekwh4gVVKI6mbx3D9HEW2oTcNwJEVaSdeQ/dNAxGN23p6R
         ON2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843502; x=1762448302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E68T2ZkjnQfOB2TtPtritiOjh/qgxTXRIYSNsvI6CzQ=;
        b=GAjgLhM1noDO2kv3EdH/ESKUdi/D1QyZV3MBjqaROJIA3Z80OxysxtIMHarKCamgAt
         cKeb1xEJeam/WUKNWvzNKDMuIQbgUyasEhJ2cdlAz1nJ92O5r8zYFKG4Q4ihhNgnl+PM
         q54NANDTVx45mbvlJYnD07oZ1U8Bm0HkeUEzcFqEW7O74uTxE6jA5iDDOP+vJdbDr0oc
         aCSUGxmJ3nOz5V6pOutNcYaq3PwbAuf1zqs/nu0+cJDaF2k9SR+SmWSNGNdtFFvoPbnD
         QaoEY4w3BJlmNCjf46gpjAd08sa2z4unKahHxXQqe2hmMlalYF6IhpxB9n4EzeRxI0oz
         SjOg==
X-Gm-Message-State: AOJu0YwH0Kj6OHOubKSf+dh2UdldrZAEbBP6/PUA3U66WMqK9DfGeg3g
	padopnjGowgBFCmAO/5NwBn03yM2xXSaNXk1cFGTzKPBd+oYqbsS4msmzlaINJrtQqONN2n8lVP
	mfWvfCNj3g/xc5AGxi5mqiMHYWr4WkKk=
X-Gm-Gg: ASbGncuIiCLOfbZOnCzfVKwSAKK615bQrmAZ1vemwynzwoJlEiFkhIeg3Qek8UbhEJJ
	2Jt1rKnGen3jVkVeTdPY+6kI6YUoVVweDGAhyQQAxvDHJVT4ZMwjB7Bqfu7g7kQdcPweMuV6EU7
	gHQTOHV4zyLCQ0i6MMy6kNlBlr4btREbaRYBPYMd5nJbmZfpaTRV8WmW1i0yN/7Re+FhgSF4YYb
	RsBnpSZewvtxGmjvbdsowMK4q9lIGe95HfYFZeX/f6vOxBJ5s4WvZKwM+9oIZ4pUvIVE7TaO7Td
	Q7GJRiyHkynbrqlmp5ZSUlJ7siBE9X1OZrLyfLnMZ3r/pAVvSBhrGIlCg9vQSi3znqobodZVM9o
	++Oqp4FAXdrza8aVv6gcR/9UOb8Ba9zPq
X-Google-Smtp-Source: AGHT+IHbrUeLeobaoyLbyIRyrMhLM50yjN3yU4t5GGhWsxndX/hdKmL0CE7lmxbO/igBCODfibDQ9Objs317x1v+yjg=
X-Received: by 2002:a53:d70b:0:b0:63e:22b1:21a5 with SMTP id
 956f58d0204a3-63f92261520mr114604d50.17.1761843502030; Thu, 30 Oct 2025
 09:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <efd2690f-35ba-4104-ac88-4e068984d19f@kernel.org> <CABPXPSKzOhGicdPLoMFy8xvd0Xx5_D2P2pduteY3QhDRV4d2Ow@mail.gmail.com>
In-Reply-To: <CABPXPSKzOhGicdPLoMFy8xvd0Xx5_D2P2pduteY3QhDRV4d2Ow@mail.gmail.com>
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
Date: Thu, 30 Oct 2025 22:28:10 +0530
X-Gm-Features: AWmQ_bkxeHE-cf9YU0GEMawPIITvstN85hgTqjgnSUTHDIlKXFHjvkCTrqkY-sI
Message-ID: <CABPXPSLKa9SasCpunrTSuoYaPcvPGTCZX+FPs9uq19m8a2XNRg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the feedback! I=E2=80=99ll resend this as a regular PATCH ser=
ies
shortly. I appreciate you taking the time to review.

Best regards,
Ajith

On Thu, Oct 30, 2025 at 10:19=E2=80=AFPM Ajith Anandhan
<ajithanandhan0406@gmail.com> wrote:
>
> Thank you for the feedback! I=E2=80=99ll resend this as regular PATCH ser=
ies shortly. I appreciate you taking the time to review.
>
> Best regards,
> Ajith
>
> On Thu, Oct 30, 2025 at 10:10=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
>>
>> On 30/10/2025 17:34, Ajith Anandhan wrote:
>> > This RFC patch series adds support for the Texas Instruments ADS1120,
>> > a precision 16-bit delta-sigma ADC with SPI interface.
>> >
>> > The driver provides:
>> > - 4 single-ended voltage input channels
>> > - Programmable gain amplifier (1 to 128)
>> > - Configurable data rates (20 to 1000 SPS)
>> > - Single-shot conversion mode
>> >
>> > I'm looking for feedback on:
>> > 1. The implementation approach for single-shot conversions
>> > 2. Any other suggestions for improvement
>>
>>
>> No need to call your patches RFC then. It only stops from merging and
>> some people will not review the code (RFC means not ready for inclusion)=
.
>>
>> Best regards,
>> Krzysztof

