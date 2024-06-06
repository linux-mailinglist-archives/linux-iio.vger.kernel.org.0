Return-Path: <linux-iio+bounces-5893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A388FE3E6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0139828880D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC78B190678;
	Thu,  6 Jun 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="frbu8+QT"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CBB1850AC;
	Thu,  6 Jun 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668742; cv=none; b=lpDl1qVoQ653HTiq8YlFY9mepcSSyyVMGwkr0KGtOWL+om2pb48m75Hl4pi5KraWI8VjYwY3Ujp08InoBvq6RZWvITXguHFSNfXuKbNgTm+Rr/mAnejSuQDSIP9elBd9QYIg7sDnVgMSM8kcdok9/Ky5qMjQBgFX/xK3DA6tke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668742; c=relaxed/simple;
	bh=xYXzgWNy4Rs2pnGAqHq93NhuNe+fr/mIyHdGMXdlv2I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UFC63fO3uhQzRFW5r2qGpzWfb4faUptS1TmNuOP4cRDpJ+YOV53wwktUAUUJwS6LJg/ZnAlNDLhV2ru5B4a3MSx31KAwR7rnbzg0rSMKolQPDN8k+eKCM36ywJbhv20JMPJWlSLZw1Bd7Z/dCxNDyufOGEuPB2w1HTvxtEDqla8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=frbu8+QT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B2252450B3;
	Thu,  6 Jun 2024 12:12:12 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dti8yqdd9amy; Thu,  6 Jun 2024 12:12:11 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1717668731; bh=xYXzgWNy4Rs2pnGAqHq93NhuNe+fr/mIyHdGMXdlv2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=frbu8+QTEOzDycjOzFRIeaEaMrFhtqv6gmw3BKHeGXNXfezD0KEXr3FwUzYpwB1ZY
	 n6+SdD72mQtmXX132cAbSFfSk/errG23epm2fn8Qa5u1knanbPVlfeseSfnH11WOCv
	 w3HcFqPz8lVxZTXUm1M60lyNgfCk0OUaSqDvRPym6CtYsjJkdg52udaRoqDz1oxBM2
	 XTeiPvRvbkMukwmdtL4crY/sCsMjwT7CbqASgGankNm/KrejqszgRM+Rwc7+HcdV1l
	 0MGnqbiO/+YobohREUBZDX4KRPm7LLjb1ItRaCWffvQqWocNq9EoC0/ri+r2pUZxhh
	 fHHDTa7B1ehxg==
Date: Thu, 06 Jun 2024 10:12:11 +0000
From: kauschluss <kauschluss@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 denis.ciocca@st.com, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 robh+dt@kernel.org, kauschluss@disroot.org
Subject: Re: [PATCH v3] iio: accel: st_accel: add LIS2DS12
In-Reply-To: <20240602095459.4a2cdc54@jic23-huawei>
References: <20240601192914.141906-1-kauschluss@disroot.org>
 <20240601-spouse-hurler-e7b93ac26f86@spud>
 <20240602095459.4a2cdc54@jic23-huawei>
Message-ID: <4ed8ba956aee82bf7ccde2af1012bae2@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-06-02 08:54, Jonathan Cameron wrote:
> On Sat, 1 Jun 2024 20:49:25 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
>> On Sun, Jun 02, 2024 at 12:56:41AM +0530, Kaustabh Chakraborty wrote:
>> > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
>> > index fd3749871121..329a4d6fb2ec 100644
>> > --- a/drivers/iio/accel/st_accel_i2c.c
>> > +++ b/drivers/iio/accel/st_accel_i2c.c
>> > @@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
>> >  		.compatible = "st,lis2de12",
>> >  		.data = LIS2DE12_ACCEL_DEV_NAME,
>> >  	},
>> > +	{
>> > +		.compatible = "st,lis2ds12",
>> > +		.data = LIS2DS12_ACCEL_DEV_NAME,
>> > +	},
>> >  	{
>> >  		.compatible = "st,lis2hh12",
>> >  		.data = LIS2HH12_ACCEL_DEV_NAME,
>> 
>> > diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
>> > index f72a24f45322..825adab37105 100644
>> > --- a/drivers/iio/accel/st_accel_spi.c
>> > +++ b/drivers/iio/accel/st_accel_spi.c
>> > @@ -64,6 +64,10 @@ static const struct of_device_id st_accel_of_match[] = {
>> >  		.compatible = "st,lis2dh12-accel",
>> >  		.data = LIS2DH12_ACCEL_DEV_NAME,
>> >  	},
>> > +	{
>> > +		.compatible = "st,lis2ds12",
>> > +		.data = LIS2DS12_ACCEL_DEV_NAME,
>> > +	},
>> >  	{
>> >  		.compatible = "st,lis3l02dq",
>> >  		.data = LIS3L02DQ_ACCEL_DEV_NAME,
>> 
>> Any new compatibles need to be documented in st,st-sensors.yaml
> 
> At the moment the st_sensors core is doing hard matching against whoami values
> which isn't good.  That should ideally be fixed and the binding for this
> device should use a fallback compatible if the statement about compatibility
> is accurate.

I apologize for not wording the description accurately. By "compatibility",
I mean that the sensor settings of LIS2DE12 (such as the gain values) seem
to be well-suited for LIS2DS12, as per my experimentation. Both devices are
manufactured by ST and have no correlation regarding compatibility whatsoever.
In that case, a fallback compatible isn't required, right?

I'll make sure to rewrite the description more accurately in v4.
 
> It may just be a case of relaxing the check in st_sensors_verify_id()
> to printing a warning not an error message and not returning an error code
> (reserving error returns in that function for bus error etc.

I agree, if you want I may send a patch for that after I'm done with this
one.

> That doesn't need to be in this patch though.  Just have the fallback
> stuff in the binding and for now we can rely on matching the more
> precise compatible.
> 
> Jonathan
> 
> 
>> 
>> Thanks,
>> Conor.
>> 

