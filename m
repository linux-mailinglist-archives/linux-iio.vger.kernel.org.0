Return-Path: <linux-iio+bounces-8299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C132F949729
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 19:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E93B21C2C
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1FD7347C;
	Tue,  6 Aug 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="GUIxXTjD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167A74E26;
	Tue,  6 Aug 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966901; cv=none; b=mks5aFXdjsuSIc6inhydfLIjcBTWmFp3cIv5kl65JhV5PR3pDg+u1SwHfUf4ilRlF3K/vbTId2d5811Qlp1T3KlkBBSvJ7pjzptTus+XW1nveknpzgJKW8PLTx0hypyhbV/97SF2TIToYyzSlZ/0b8xHHxKhjnjfcdxalwcnPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966901; c=relaxed/simple;
	bh=pITPNxK6NWuL3mgYX/ey5UVzu5AmbaccLKqozNMWZMY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ChT470qQvJX0SYM2cHhvq+R4XP+d5VLCgHvZqmf/SRhJEDZByiqQ0vxC98B58k8PiBlfDykeU6m/kVa2w4gRA15WsWV9hfSh1XqgXVWEaEfYopMhMc9sZbp87YvZNrzB9mt3mFF/eNaOVn8r6pNqIuOei6PDMV51JDdYzXOfiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=GUIxXTjD; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [127.0.0.1] (254C310E.nat.pool.telekom.hu [37.76.49.14])
	by mail.mainlining.org (Postfix) with ESMTPSA id 2CEABE450D;
	Tue,  6 Aug 2024 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1722966897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9xC00bI7x2D+/ssVTv2fzqiBPxsHC1NlAvczmix+jw=;
	b=GUIxXTjDHIauCrUXq8q1KdmQ6PL2uU71zUvJ5KOQelYo6sjUQ4sUKntdwBE0VCysq2n+Dg
	KcxS/6N4L/X7Sg77feb8PzRFsLrF8axWT2yHq5yi+gZr0Ti7e37ZxpmRS9ZldwEzeL6RZD
	dmJlY5Y7MgSaRrBDUlsjfdzNfv+fVeDml1VrFuW9sMbNGgHwA9vHhMyxsPlIzDWa7uxPkV
	J/ELvb6IjI0fx0MDrQnsfRBrl7BoTVlRTbguyZ5tMia1cs20FoF8q9zGoFGRcQQ+si79PX
	O+xPcEOeRusyiI/zxKtNrx23DmCyyyj34tDGSggIDJxj6XuMrADdcCP0KM/P0Q==
Date: Tue, 06 Aug 2024 19:54:56 +0200
From: =?ISO-8859-1?Q?Barnab=E1s_Cz=E9m=E1n?= <barnabas.czeman@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux@mainlining.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/3=5D_iio=3A_magnetometer=3A_?=
 =?US-ASCII?Q?ak8975=3A_Fix_reading_for_ak099xx_sensors?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240806171925.7c512c63@jic23-huawei>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org> <20240806-ak09918-v2-1-c300da66c198@mainlining.org> <20240806171925.7c512c63@jic23-huawei>
Message-ID: <45915CD6-A9BB-4071-ABCC-8DE76F7066C3@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 6, 2024 6:19:25 PM GMT+02:00, Jonathan Cameron <jic23@kernel=2Eo=
rg> wrote:
>On Tue, 06 Aug 2024 08:10:18 +0200
>Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas=2Eczeman@mainlining=2Eorg> wrote=
:
>
>Hi Barnab=C3=A1s,
>
>Welcome to IIO=2E
>
>> ST2 register read should be placed after read measurment data,
>> because it will get correct values after it=2E
>
>What is the user visible result of this? Do we detect errors when none
>are there?  Do we have a datasheet reference for the status being
>update on the read command, not after the trigger?

Second read will fail=2E In the datasheet ST2 comes after measurment data =
read=2E Here is some explanation from datasheet=2E

"When ST2 register is read, AK09918 judges that data reading is finished=
=2E Stored measurement data is
protected during data reading and data is not updated=2E By reading ST2 re=
gister, this protection is
released=2E It is required to read ST2 register after data reading=2E"

So if ST2 is read before measurment it will stuck at protected mode=2E
>>
>Needs a Fixes tag to let us know how far to backport the fix=2E
I think it is broken since 09912 was added but i cannot verify i have only=
 devices with 09918=2E
>
>A few comments inline=2E
>=20
>> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas=2Eczeman@mainli=
ning=2Eorg>
>> ---
>>  drivers/iio/magnetometer/ak8975=2Ec | 31 +++++++++++++++--------------=
--
>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/drivers/iio/magnetometer/ak8975=2Ec b/drivers/iio/magnetom=
eter/ak8975=2Ec
>> index dd466c5fa621=2E=2E925d76062b3e 100644
>> --- a/drivers/iio/magnetometer/ak8975=2Ec
>> +++ b/drivers/iio/magnetometer/ak8975=2Ec
>> @@ -692,22 +692,7 @@ static int ak8975_start_read_axis(struct ak8975_da=
ta *data,
>>  	if (ret < 0)
>>  		return ret;
>> =20
>> -	/* This will be executed only for non-interrupt based waiting case */
>> -	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
>> -		ret =3D i2c_smbus_read_byte_data(client,
>> -					       data->def->ctrl_regs[ST2]);
>> -		if (ret < 0) {
>> -			dev_err(&client->dev, "Error in reading ST2\n");
>> -			return ret;
>> -		}
>> -		if (ret & (data->def->ctrl_masks[ST2_DERR] |
>> -			   data->def->ctrl_masks[ST2_HOFL])) {
>> -			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
>> -			return -EINVAL;
>> -		}
>> -	}
>> -
>This completely removes the check from the _fill_buffer() path
>
>> -	return 0;
>> +	return !(ret & data->def->ctrl_masks[ST1_DRDY]);
>returning a positive value here is unusual enough you should add a commen=
t for
>the function + use that return value=2E
>
>>  }
>> =20
>>  /* Retrieve raw flux value for one of the x, y, or z axis=2E  */
>> @@ -731,6 +716,20 @@ static int ak8975_read_axis(struct iio_dev *indio_=
dev, int index, int *val)
>>  	ret =3D i2c_smbus_read_i2c_block_data_or_emulated(
>>  			client, def->data_regs[index],
>>  			sizeof(rval), (u8*)&rval);
>No longer gated on ret & data->def->ctrl_masks[ST1_DRDY] which seems unin=
tentional=2E
>
>Still need a check on ret here=2E
>
>> +	ret =3D i2c_smbus_read_byte_data(client,
>> +				       data->def->ctrl_regs[ST2]);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Error in reading ST2\n");
>> +		goto exit;
>> +	}
>> +
>> +	if (ret & (data->def->ctrl_masks[ST2_DERR] |
>> +		   data->def->ctrl_masks[ST2_HOFL])) {
>> +		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
>> +		ret =3D -EINVAL;
>> +		goto exit;
>> +	}
>> +
>>  	if (ret < 0)
>>  		goto exit;
>
>And this one ends up redundant I think which suggests to me the
>code is inserted a few lines early=2E
>
>> =20
>>=20
>

