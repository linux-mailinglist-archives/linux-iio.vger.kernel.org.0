Return-Path: <linux-iio+bounces-21596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99824B02D6F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 00:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8253167C99
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jul 2025 22:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795382AE6A;
	Sat, 12 Jul 2025 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKamApBt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3922094;
	Sat, 12 Jul 2025 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752358598; cv=none; b=iIB/bSUgpSyI/poXOF46D3kxdvk4EUUbmgHqEKffFVEuyoB7okCyrsEJz5Gr0udc1xAF3WGqUnUlg92IjP/g76lam9hZU/QCtZl4lJ0cx9Ts+Cc59BjC0awWEPziLziuKVIm07PTCT0ttTaOeS5BBJlmK7DMckSChtXYYH7qZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752358598; c=relaxed/simple;
	bh=F+oHiZeATWk7cH+yoFtp77I/m1u1NJ+hRPH1xEcCvKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6WhOWLfB3vbSb9/wDdGJh2P0wchAUIne3RnWyAFJ15dXsooI9yaiIC4zk7ofVVApPhuukIWKjxok8Y7MLTDuECXc/NWF1nbIHDjm7VNW/5gh20ME0CudBRynbO7j3+FicblSnmZBtygWW3FQcYgmzHaPrC+7htOvJLTmOo7gsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKamApBt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752358597; x=1783894597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+oHiZeATWk7cH+yoFtp77I/m1u1NJ+hRPH1xEcCvKk=;
  b=PKamApBtgmF32sRcUH2+D8jWvK/P/hRHaGX+mQj3eUMCHqVJrXTm/LFE
   PYb63IuqEL8gcjW5ZHXL1X+FeCLjgwmk9Ob2kgFPgm3+4yg/cjds4csZE
   Qp/muf6ZCEeiNAh3KQ8QS5Ftzl5gfFpDSlaBm2F+4q4HFqzu3UzF8aLww
   lYdyOlxJmavt9nGXnDP3gbtWHQNYvRb6VP3m60x/T6StgPbxJT3GhkGv2
   8SrPSh9sTW/voMHyW6OR4qsEvb33CTDTfY507gKjlgWmFUQtFhDol3yKl
   50EvFcU91kSSNBM8wLttCZsN/qO6UXHa5OyJ8qVGIyks4YtWbEZN41gbj
   w==;
X-CSE-ConnectionGUID: kumsrj3tQnCR8P9dqjgXoQ==
X-CSE-MsgGUID: CWf+/X/jTYmB3kcZ5lJwfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54765920"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="54765920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 15:16:36 -0700
X-CSE-ConnectionGUID: JkkpHCcBQzi6MR0nCWGoiQ==
X-CSE-MsgGUID: uQdH5NLaRi+fi4KDjJxTvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="187614569"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jul 2025 15:16:29 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaiWA-0007it-21;
	Sat, 12 Jul 2025 22:16:26 +0000
Date: Sun, 13 Jul 2025 06:16:04 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH 3/3] iio: adc: add ade9000 support
Message-ID: <202507130521.iaXBguXP-lkp@intel.com>
References: <20250711130241.159143-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711130241.159143-4-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.16-rc5 next-20250711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-add-power-and-energy-measurement-modifiers/20250712-022300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250711130241.159143-4-antoniu.miclaus%40analog.com
patch subject: [PATCH 3/3] iio: adc: add ade9000 support
config: arc-randconfig-r133-20250713 (https://download.01.org/0day-ci/archive/20250713/202507130521.iaXBguXP-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250713/202507130521.iaXBguXP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130521.iaXBguXP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ade9000.c:1176:40: sparse: sparse: cast truncates bits from constant value (100000 becomes 0)
   drivers/iio/adc/ade9000.c:1185:40: sparse: sparse: cast truncates bits from constant value (200000 becomes 0)
   drivers/iio/adc/ade9000.c:1194:40: sparse: sparse: cast truncates bits from constant value (400000 becomes 0)
   drivers/iio/adc/ade9000.c:1203:40: sparse: sparse: cast truncates bits from constant value (800000 becomes 0)
   drivers/iio/adc/ade9000.c:1212:40: sparse: sparse: cast truncates bits from constant value (1000000 becomes 0)
   drivers/iio/adc/ade9000.c:1221:40: sparse: sparse: cast truncates bits from constant value (2000000 becomes 0)
   drivers/iio/adc/ade9000.c:1230:40: sparse: sparse: cast truncates bits from constant value (40000 becomes 0)
   drivers/iio/adc/ade9000.c:1249:12: sparse: sparse: context imbalance in 'ade9000_read_raw' - different lock contexts for basic block
>> drivers/iio/adc/ade9000.c:1761:9: sparse: sparse: dereference of noderef expression
>> drivers/iio/adc/ade9000.c:1761:9: sparse: sparse: dereference of noderef expression

vim +1176 drivers/iio/adc/ade9000.c

  1051	
  1052	static irqreturn_t ade9000_irq1_thread(int irq, void *data)
  1053	{
  1054		struct iio_dev *indio_dev = data;
  1055		struct ade9000_state *st = iio_priv(indio_dev);
  1056		unsigned int bit = ADE9000_ST1_CROSSING_FIRST;
  1057		s64 timestamp = iio_get_time_ns(indio_dev);
  1058		u32 handled_irq = 0;
  1059		u32 interrupts;
  1060		u32 result;
  1061		u32 status;
  1062		u32 tmp;
  1063		int ret;
  1064	
  1065		if (!st->rst_done) {
  1066			ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &result);
  1067			if (ret)
  1068				return ret;
  1069	
  1070			if (result & ADE9000_ST1_RSTDONE_BIT)
  1071				st->rst_done = true;
  1072			else
  1073				dev_err(&st->spi->dev, "Error testing reset done");
  1074	
  1075			return IRQ_HANDLED;
  1076		}
  1077	
  1078		ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &status);
  1079		if (ret)
  1080			return IRQ_HANDLED;
  1081	
  1082		ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts);
  1083		if (ret) {
  1084			dev_err(&st->spi->dev, "IRQ1 read status fail");
  1085			return IRQ_HANDLED;
  1086		}
  1087	
  1088		for_each_set_bit_from(bit, (unsigned long *)&interrupts,
  1089				      ADE9000_ST1_CROSSING_DEPTH){
  1090			tmp = status & BIT(bit);
  1091	
  1092			switch (tmp) {
  1093			case ADE9000_ST1_ZXVA_BIT:
  1094				iio_push_event(indio_dev,
  1095					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1096								    ADE9000_ST1_ZXVA_BIT,
  1097								    IIO_EV_TYPE_THRESH,
  1098								    IIO_EV_DIR_EITHER),
  1099					       timestamp);
  1100				handled_irq |= ADE9000_ST1_ZXVA_BIT;
  1101				break;
  1102			case ADE9000_ST1_ZXTOVA_BIT:
  1103				iio_push_event(indio_dev,
  1104					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1105								    ADE9000_ST1_ZXTOVA_BIT,
  1106								    IIO_EV_TYPE_THRESH,
  1107								    IIO_EV_DIR_EITHER),
  1108					       timestamp);
  1109				handled_irq |= ADE9000_ST1_ZXTOVA_BIT;
  1110				break;
  1111			case ADE9000_ST1_ZXIA_BIT:
  1112				iio_push_event(indio_dev,
  1113					       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
  1114								    ADE9000_ST1_ZXIA_BIT,
  1115								    IIO_EV_TYPE_THRESH,
  1116								    IIO_EV_DIR_EITHER),
  1117					       timestamp);
  1118				handled_irq |= ADE9000_ST1_ZXIA_BIT;
  1119				break;
  1120			case ADE9000_ST1_ZXVB_BIT:
  1121				iio_push_event(indio_dev,
  1122					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1123								    ADE9000_ST1_ZXVB_BIT,
  1124								    IIO_EV_TYPE_THRESH,
  1125								    IIO_EV_DIR_EITHER),
  1126					       timestamp);
  1127				handled_irq |= ADE9000_ST1_ZXVB_BIT;
  1128				break;
  1129			case ADE9000_ST1_ZXTOVB_BIT:
  1130				iio_push_event(indio_dev,
  1131					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1132								    ADE9000_ST1_ZXTOVB_BIT,
  1133								    IIO_EV_TYPE_THRESH,
  1134								    IIO_EV_DIR_EITHER),
  1135					       timestamp);
  1136				handled_irq |= ADE9000_ST1_ZXTOVB_BIT;
  1137				break;
  1138			case ADE9000_ST1_ZXIB_BIT:
  1139				iio_push_event(indio_dev,
  1140					       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
  1141								    ADE9000_ST1_ZXIB_BIT,
  1142								    IIO_EV_TYPE_THRESH,
  1143								    IIO_EV_DIR_EITHER),
  1144					       timestamp);
  1145				handled_irq |= ADE9000_ST1_ZXIB_BIT;
  1146				break;
  1147			case ADE9000_ST1_ZXVC_BIT:
  1148				iio_push_event(indio_dev,
  1149					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1150								    ADE9000_ST1_ZXVC_BIT,
  1151								    IIO_EV_TYPE_THRESH,
  1152								    IIO_EV_DIR_EITHER),
  1153					       timestamp);
  1154				handled_irq |= ADE9000_ST1_ZXVC_BIT;
  1155				break;
  1156			case ADE9000_ST1_ZXTOVC_BIT:
  1157				iio_push_event(indio_dev,
  1158					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1159								    ADE9000_ST1_ZXTOVC_BIT,
  1160								    IIO_EV_TYPE_THRESH,
  1161								    IIO_EV_DIR_EITHER),
  1162					       timestamp);
  1163				handled_irq |= ADE9000_ST1_ZXTOVC_BIT;
  1164				break;
  1165			case ADE9000_ST1_ZXIC_BIT:
  1166				iio_push_event(indio_dev,
  1167					       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
  1168								    ADE9000_ST1_ZXIC_BIT,
  1169								    IIO_EV_TYPE_THRESH,
  1170								    IIO_EV_DIR_EITHER),
  1171					       timestamp);
  1172				handled_irq |= ADE9000_ST1_ZXIC_BIT;
  1173				break;
  1174			case ADE9000_ST1_SWELLA_BIT:
  1175				iio_push_event(indio_dev,
> 1176					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1177								    ADE9000_ST1_SWELLA_BIT,
  1178								    IIO_EV_TYPE_THRESH,
  1179								    IIO_EV_DIR_RISING),
  1180					       timestamp);
  1181				handled_irq |= ADE9000_ST1_SWELLA_BIT;
  1182				break;
  1183			case ADE9000_ST1_SWELLB_BIT:
  1184				iio_push_event(indio_dev,
  1185					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1186								    ADE9000_ST1_SWELLB_BIT,
  1187								    IIO_EV_TYPE_THRESH,
  1188								    IIO_EV_DIR_RISING),
  1189					       timestamp);
  1190				handled_irq |= ADE9000_ST1_SWELLB_BIT;
  1191				break;
  1192			case ADE9000_ST1_SWELLC_BIT:
  1193				iio_push_event(indio_dev,
  1194					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1195								    ADE9000_ST1_SWELLC_BIT,
  1196								    IIO_EV_TYPE_THRESH,
  1197								    IIO_EV_DIR_RISING),
  1198					       timestamp);
  1199				handled_irq |= ADE9000_ST1_SWELLC_BIT;
  1200				break;
  1201			case ADE9000_ST1_DIPA_BIT:
  1202				iio_push_event(indio_dev,
  1203					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1204								    ADE9000_ST1_DIPA_BIT,
  1205								    IIO_EV_TYPE_THRESH,
  1206								    IIO_EV_DIR_FALLING),
  1207					       timestamp);
  1208				handled_irq |= ADE9000_ST1_DIPA_BIT;
  1209				break;
  1210			case ADE9000_ST1_DIPB_BIT:
  1211				iio_push_event(indio_dev,
  1212					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1213								    ADE9000_ST1_DIPB_BIT,
  1214								    IIO_EV_TYPE_THRESH,
  1215								    IIO_EV_DIR_FALLING),
  1216					       timestamp);
  1217				handled_irq |= ADE9000_ST1_DIPB_BIT;
  1218				break;
  1219			case ADE9000_ST1_DIPC_BIT:
  1220				iio_push_event(indio_dev,
  1221					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1222								    ADE9000_ST1_DIPC_BIT,
  1223								    IIO_EV_TYPE_THRESH,
  1224								    IIO_EV_DIR_FALLING),
  1225					       timestamp);
  1226				handled_irq |= ADE9000_ST1_DIPC_BIT;
  1227				break;
  1228			case ADE9000_ST1_SEQERR_BIT:
  1229				iio_push_event(indio_dev,
  1230					       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
  1231								    ADE9000_ST1_SEQERR_BIT,
  1232								    IIO_EV_TYPE_CHANGE,
  1233								    IIO_EV_DIR_NONE),
  1234					       timestamp);
  1235				handled_irq |= ADE9000_ST1_SEQERR_BIT;
  1236				break;
  1237			default:
  1238				return IRQ_HANDLED;
  1239			}
  1240		}
  1241	
  1242		ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, handled_irq);
  1243		if (ret)
  1244			return ret;
  1245	
  1246		return IRQ_HANDLED;
  1247	}
  1248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

