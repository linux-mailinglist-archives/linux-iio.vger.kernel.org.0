Return-Path: <linux-iio+bounces-11953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD19BFACD
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 01:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1666B21C3A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CEE3D64;
	Thu,  7 Nov 2024 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li37jDdn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA06FBF;
	Thu,  7 Nov 2024 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939817; cv=none; b=C1kXuo2Q7UuWBhB9V5a1q7ieHnfUgh8Bcn47CJUwo7M14R/nEZcheC34AXhPZFRHxg0uuAFgkVCuJa3DKpEAC9x4CJJOvS82VCL0YXOKGGazwB/4bNh980cmjPIMkM6TkL4AtgSTi0tjGNd1MFiLyFU4Z29nBSUFYCMKJThhxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939817; c=relaxed/simple;
	bh=mMqrFTabFjPuJ5L1SvFAqtifseKaAG/U8UbokBKH5dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ7rqnvb3iEgRHMbPWPnsAxrQtVfgzRzgjZz0wtsd44cOAnCT1OBnQSlxWfAdZTNiUCdt4OyMU9Cp5oZhkZa8FYtV6dGACgOEuNrXY0HNgweI2P96Z3FHVFFEa9stZemoQ+X9XUs7n0bjEIt8hYe3f39c08xZkzLLLe2cj/DuVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li37jDdn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a850270e2so59370066b.0;
        Wed, 06 Nov 2024 16:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730939814; x=1731544614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ2KJqDDlr0BpJVm1jVxEVWBDpJgOHV/yUofgteoeys=;
        b=Li37jDdnNuHAttHwwT61+MT7hLIcufOiAxdQ6cAR7yM2lunrhK5aGR4CMXWIqlzC1K
         +Ngq459Rl8GSX9RWNEucA4kLHA5a4E5kRv4aNTijv1b8xooXSRuA+GxhcT6kkptRIX1J
         oxI5//1qF0HDWefK2G+DiAzpsfGdqYekQAGok3gwwdp92a2bMcL7d4v/zwUEUv3Jd5Jd
         xqufnttrRaZh+OapKGM+USUCVPhGScYktJjbIxDgv8wMCxnStA9vT57y+z9NV7cY1NFx
         aIRGHJAMHeZBgJacxVzj8dXwfr/VKW23DcBGLiL5tHmKYBh+oFjwb4x/b6tk04H6f+jw
         B3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730939814; x=1731544614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ2KJqDDlr0BpJVm1jVxEVWBDpJgOHV/yUofgteoeys=;
        b=Kpecj5KOebA3toC8wvplaA9otnUbBdbVxIumXkG8D+5/EO8iJfw/f729ofgbwWbo5f
         CR1NN+trSZYL6iltScT2mZ4iD3SFfyGHYYeMs2wuqLb86+A9OEmt2gAmGu9NNYnVQ24p
         v4Buwg4qDcF5qnZfKU7yyx6inRveoN+X6nr9nWAHV/5/o+QwsK4Q92V4mrg16NwEDA+/
         lHzQqB1TjShGh8z6+h3gb7jKxiVR4wn8wa2QmO2mR2EGyfiMyXVBnABVGjk5uJfIPBue
         2VedGN4v1s4JG5N4akr85ZwfruxMf7O4r0MKCHfvRG+ZOmJRmTGmkIKSA4imYWipiy5b
         Z7WA==
X-Forwarded-Encrypted: i=1; AJvYcCUo4Pjec20LB+7oilL+ohJ7fdxoQerv8MEXj2xb+1jYRcdrH1XgQPOpBtT6T7eZL9NSQxyrhx8hiast@vger.kernel.org, AJvYcCVsyHXdbBoOvg+QgyX21qoJHb7YnXWpv8kARJGtC1FoXJdKIqSSMWyRqCVyV1jZkxL0xeNnA2RVu0tJigkX@vger.kernel.org, AJvYcCWL5T38/7jP/oiA0TcWERj55jGxXvjQ8NwPwqAZAhT58eF6OuhHWV1qA7k/gbNFywQPpAu8Yu44/HSy@vger.kernel.org
X-Gm-Message-State: AOJu0YxkP6fegaChhWkWKrDJKm1nA56jvvyamDxmOx0BUgCQxQLKcT8i
	qTCsDsjJ0kIfuym6EhP2VsGNtBFwT6AOfBgmBQ4P3nIbefyTKnQMHtAaYrX3PbwTa5gCkYbtVyx
	7WJfXrFI1c+FCKSva0KWQWt/w8O2yUU826cE=
X-Google-Smtp-Source: AGHT+IETkScOSUxZd3ErqQbo+kcXH+PXR3sYrQW1guLOYuIVBc/zfUsa7sINCKMLWwhvbWzDzuqURQ9iowF7aNpXvoo=
X-Received: by 2002:a17:907:2d91:b0:a9a:80cc:c972 with SMTP id
 a640c23a62f3a-a9e655a8980mr2108644366b.27.1730939813501; Wed, 06 Nov 2024
 16:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-3-j2anfernee@gmail.com> <202411062051.TLRkJSSL-lkp@intel.com>
In-Reply-To: <202411062051.TLRkJSSL-lkp@intel.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Thu, 7 Nov 2024 08:36:16 +0800
Message-ID: <CA+4VgcKXQ4padSHBpnmw_vN5WWL+GfcJqOCtthN88C1hwicb6A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: kernel test robot <lkp@intel.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, joao.goncalves@toradex.com, 
	marius.cristea@microchip.com, mike.looijmans@topic.nl, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, openbmc@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear kernel test robot,

Thank you for your response.
I would check these warnings.

kernel test robot <lkp@intel.com> =E6=96=BC 2024=E5=B9=B411=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Eason,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linus/master v6.12-rc6 next-20241106]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eason-Yang/dt-bind=
ings-iio-adc-Add-binding-for-Nuvoton-NCT720x-ADCs/20241106-104046
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tog=
reg
> patch link:    https://lore.kernel.org/r/20241106023916.440767-3-j2anfern=
ee%40gmail.com
> patch subject: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/202411=
06/202411062051.TLRkJSSL-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5=
92c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241106/202411062051.TLRkJSSL-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411062051.TLRkJSSL-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/iio/adc/nct720x.c:9:
>    In file included from include/linux/device.h:32:
>    In file included from include/linux/device/driver.h:21:
>    In file included from include/linux/module.h:19:
>    In file included from include/linux/elf.h:6:
>    In file included from arch/s390/include/asm/elf.h:181:
>    In file included from arch/s390/include/asm/mmu_context.h:11:
>    In file included from arch/s390/include/asm/pgalloc.h:18:
>    In file included from include/linux/mm.h:2213:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:518:36: warning: arithmetic between different e=
numeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-c=
onversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip =
"nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:524:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      525 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/iio/adc/nct720x.c:526:16: warning: cast to smaller integer typ=
e 'enum nct720x_chips' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>      526 |                 chip->type =3D (enum nct720x_chips)device_get_=
match_data(&client->dev);
>          |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~
>    5 warnings generated.
>
>
> vim +526 drivers/iio/adc/nct720x.c
>
>    511
>    512  static int nct720x_probe(struct i2c_client *client)
>    513  {
>    514          const struct i2c_device_id *id =3D i2c_client_get_device_=
id(client);
>    515          struct nct720x_chip_info *chip;
>    516          struct iio_dev *indio_dev;
>    517          int ret;
>    518          u32 tmp;
>    519
>    520          indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(=
*chip));
>    521          if (!indio_dev)
>    522                  return -ENOMEM;
>    523          chip =3D iio_priv(indio_dev);
>    524
>    525          if (client->dev.of_node)
>  > 526                  chip->type =3D (enum nct720x_chips)device_get_mat=
ch_data(&client->dev);
>    527          else
>    528                  chip->type =3D i2c_match_id(nct720x_id, client)->=
driver_data;
>    529
>    530          chip->vin_max =3D (chip->type =3D=3D nct7201) ? NCT7201_V=
IN_MAX : NCT7202_VIN_MAX;
>    531
>    532          ret =3D of_property_read_u32(client->dev.of_node, "read-v=
in-data-size", &tmp);
>    533          if (ret < 0) {
>    534                  pr_err("read-vin-data-size property not found\n")=
;
>    535                  return ret;
>    536          }
>    537
>    538          if (tmp =3D=3D 8) {
>    539                  chip->use_read_byte_vin =3D true;
>    540          } else if (tmp =3D=3D 16) {
>    541                  chip->use_read_byte_vin =3D false;
>    542          } else {
>    543                  pr_err("invalid read-vin-data-size (%d)\n", tmp);
>    544                  return -EINVAL;
>    545          }
>    546
>    547          mutex_init(&chip->access_lock);
>    548
>    549          /* this is only used for device removal purposes */
>    550          i2c_set_clientdata(client, indio_dev);
>    551
>    552          chip->client =3D client;
>    553
>    554          ret =3D nct720x_init_chip(chip);
>    555          if (ret < 0)
>    556                  return ret;
>    557
>    558          indio_dev->name =3D id->name;
>    559          indio_dev->channels =3D nct720x_channels;
>    560          indio_dev->num_channels =3D ARRAY_SIZE(nct720x_channels);
>    561          indio_dev->info =3D &nct720x_info;
>    562          indio_dev->modes =3D INDIO_DIRECT_MODE;
>    563
>    564          iio_device_register(indio_dev);
>    565
>    566          return 0;
>    567  }
>    568
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

