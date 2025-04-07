Return-Path: <linux-iio+bounces-17763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC5A7E030
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 15:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E141B17E9E7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C61C07C4;
	Mon,  7 Apr 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP2N10Qg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FBB18309C;
	Mon,  7 Apr 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033964; cv=none; b=Rx9nXlcDkKmhcIcIy6Xs8VRr3rbG39pfCb5hp+mF6CVMmjU9jpvPwbYiS5TOcI4m4fQ9ST24BU36y/mxJ5bg4FZrffpQSp8PMVMG/Kb4p71LUwE0bWhB5VdolFdK4lnZRDXnn7XXPo26iHuny9qS6BmClBCSVmgww9UjX9/sh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033964; c=relaxed/simple;
	bh=pa83JoLiOPU6QvFW/d1z/pQEvJXRucrMVpIOQJycOlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np0eGMyQcBCYvDlBXQLyEuWOIrg8WeDInGZ0e0FSw7a+/KPFk1S/mrsx79MC/0UHd8YSnBgg7+y+an2tGbnXwXdP19sUHpNrmxMNtvwLkYDIaJIbS5abPDL0ydvH+5VD830aUTBdrj7/7EuRWOkQFGwMzcCuB7kV3KSExi8q0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP2N10Qg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac34257295dso892409066b.2;
        Mon, 07 Apr 2025 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744033961; x=1744638761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc9bjfbFTJWsLLxoFhUmoW8tGe7xoApEt1z4G7mllw8=;
        b=MP2N10QgGXWd3kkXsPM+GcA/RxKH6QcT04IgRcYuXYvRcubi34Y3Fs6WKp0wQ0LLWb
         2VvDIhueMt/suFbenGjX40q+YTjSbRsdR3cYWwE/5Uo3EgHF8QijNvMpQw776+uv0bl2
         cxAjjduw4+XGM/iBVxdO4OhmwyL/N7rBmtWxs3pT6ZUTSbnVFeFvYxmZ74LbaHk1ZVDe
         0RaPuAn5qbbVE5bwoQp4xJpVKtJ27lZNTT8T+zT4qTMsgp3cEwcQO/izyHw25tAWnKzt
         KV5Jm6vn4Dx55L3YDN9atUkIw9dw1wtNemqpyzNuyPGov2G9/EQVriXgUXkJvKX7/6Ut
         VLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744033961; x=1744638761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sc9bjfbFTJWsLLxoFhUmoW8tGe7xoApEt1z4G7mllw8=;
        b=ht+RHdTtYC2mWvpVfUUYAA9onl7SDmjVjuIg5JVZc3rHMDu5EXkYEAEppsQpxxK1Qh
         +SaxROTrCcYV74iSQUYzB0Ja5LWdQjdMj7wzxYEZwGTlQ/E6mJtbd/Onk+RQwxjEYsTk
         K8+nQKeAR/aG393GU7Xq05vGOwwLFYHQwC0qkfznHE67cPBP2OJFVKkVzZySABnDoJf4
         nSOQZyVS5fN3Yn/qlV5jiuyUz1584ZuEmGcKI4ZadNpdxQ4lV4JClvykmhypex/Yj2og
         k98xoQzrHBMWcPMPd4fktzQ8OMuWdSkD3OrJTkVTG5J4J6ix8sJlm6RPwMG0ZPD7cjVP
         mZDw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/qqcz6FCxBKxFAwg9w/ycLgi/A5stqb2noT3pTFZ3qZJ8Liy3aIRkCpzlcy4ECOJVNHsLqqTPXyJMax/@vger.kernel.org, AJvYcCUjU/tots9yfLBfrBAXLd7o4rhkMktUe4HcfIcTLfSXkHKQWL2Js9qe3Yap9M3FORC/tuETZ4MMghmM@vger.kernel.org, AJvYcCWNnQH4XbIp4P77AR8Cq2GXDaXlJe6nfbCsWi1U2u8tMT6EX2n4dAk6MFU6TW6jrhqHyAdI66LKGwtj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22Q3c8GVFo4diyQZqfpUlFbBOrFs3tCHM4/8FEQv/8F8ttyTa
	hqb/1f83cqKpFy6TsvWllA6+pXCVJQlWbKB0ITrfgGeze8DtY3vle+rnFRg6p2q6MZzlR81KORK
	NH9Zf+LkaTw1YW0C+f4qR/GLuyUY=
X-Gm-Gg: ASbGnct47dNItmHOQjG5NsvwOoWJ82yYo4/N9YU5vi5obQrkcmpWaPEkkWSxHlu82KI
	9D15tG8ydorhT4sV0hSRNt3kTw3I+/mC/x1/Gj60r6PkN/j+Uhsetsc5ZlJFm9xyfgAxu8mbOPm
	1lF3GH5BWu2spKRKxI5STlDl5oUMCz2U/Pgj0=
X-Google-Smtp-Source: AGHT+IE1K4KGssIOLmHorIy1oCMgGcf7x4fMQ+kzwtl7JUPWt1uEuI2jriF2sy5AIG+moU2mpDY/XKHdVul9jZaECm8=
X-Received: by 2002:a17:907:7ea1:b0:ac7:b363:862c with SMTP id
 a640c23a62f3a-ac7d6d7f0a5mr1097419366b.34.1744033960765; Mon, 07 Apr 2025
 06:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221090918.1487689-1-j2anfernee@gmail.com> <20250222152537.2a24d80f@jic23-huawei>
In-Reply-To: <20250222152537.2a24d80f@jic23-huawei>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Mon, 7 Apr 2025 21:51:41 +0800
X-Gm-Features: ATxdqUFpGtpfSv-jv-HNzINZS8uIB_7m0tbvAuk-oq0i06yBUK38wFK3X9HpdrU
Message-ID: <CA+4VgcJL7pi6y55N6QaUKNkOTqTKkF8dAo+5syvRCbx7gW+ehQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, 
	andriy.shevchenko@linux.intel.com, gstols@baylibre.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com, 
	matteomartelli3@gmail.com, marcelo.schmitt@analog.com, alisadariana@gmail.com, 
	joao.goncalves@toradex.com, thomas.bonnefille@bootlin.com, 
	ramona.nechita@analog.com, herve.codina@bootlin.com, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan,

Thanks again for the review

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2025=E5=B9=B42=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8811:25=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Fri, 21 Feb 2025 17:09:16 +0800
> Eason Yang <j2anfernee@gmail.com> wrote:
>
> Hi Eason,
>
> Not sure if I asked this before, but this is a device that seems
> to be typically used for hardware monitoring and there are a number
> of similar sounding device in drivers/hwmon/
>
> That raises a couple of questions:
> 1) Is it compatible with any of those existing drivers?

No, we need a new driver to do the ADC conversion for NCT7201/NCT7202.

> 2) Why IIO rather than HWMON?

A driver for NCT7201 with more functionality is available in the iio
adc subsystem.
If the chip is used for hardware monitoring, the iio->hwmon bridge
should be used.
>
> There isn't normally a problem with having a hardware monitoring
> related device supported by IIO, it is just good to know if your
> usecase makes that a good idea.  We have the iio-hwmon bridge
> driver to solve the problem of a device than can be used either
> as a generic ADC or as a hwmon type monitoring device (which tends
> to have more alarms etc)

Yes, we also verify the iio-hwmon bridge.

>
> Jonathan
>
>
> > Change since version 4:
> >  - Fix comments
> >  - Add interrupts and reset-gpios to the DT example
> >  - Use the FIELD_PREP and FIELD_GET
> >  - Add use_single_write in regmap_config
> >  - Use regmap_access_table
> >
> > Change since version 3:
> >  - Fix comments
> >  - Don't put nct720"x" in the name, just call it nct7201
> >  - Remove differential inputs until conversions are finished
> >  - Add NCT7201_ prefix in all macros and avoid the tables
> >  - Correct event threshold values in raw units
> >  - Add with and without interrupt callback function to have the event
> >    config part and one that doesn't
> >  - Remove print an error message if regmap_wirte failed case
> >
> > Change since version 2:
> >  - Remvoe read-vin-data-size property, default use read word vin data
> >  - Use regmap instead of i2c smbus API
> >  - IIO should be IIO_CHAN_INFO_RAW and _SCALE not _PROCESSED
> >  - Use dev_xxx_probe in probe function and dev_xxx in other functions
> >  - Use devm_iio_device_register replace of iio_device_register
> >  - Use guard(mutex) replace of mutex_lock
> >  - Use get_unaligned_le16 conversion API
> >
> > Changes since version 1:
> >  - Add new property in iio:adc binding document
> >  - Add new driver for Nuvoton NCT720x driver
> >
> > Eason Yang (2):
> >   dt-bindings: iio: adc: add NCT7201 ADCs
> >   iio: adc: add support for Nuvoton NCT7201
> >
> >  .../bindings/iio/adc/nuvoton,nct7201.yaml     |  57 ++
> >  MAINTAINERS                                   |   2 +
> >  drivers/iio/adc/Kconfig                       |  11 +
> >  drivers/iio/adc/Makefile                      |   1 +
> >  drivers/iio/adc/nct7201.c                     | 487 ++++++++++++++++++
> >  5 files changed, 558 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,n=
ct7201.yaml
> >  create mode 100644 drivers/iio/adc/nct7201.c
> >
>

