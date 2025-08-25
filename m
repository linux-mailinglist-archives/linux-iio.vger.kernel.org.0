Return-Path: <linux-iio+bounces-23222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D368B34039
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9DD189F172
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107DA1CEAA3;
	Mon, 25 Aug 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jA7KjOnd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EAF2B9A7
	for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126843; cv=none; b=hU4T46epMGYLxi2W0wYY4FjIFFS3/Vf6RNktbyAGL5Te2bQ0/L8odPVblfBVOocuuoYacQBDuFOhFcLiHHQlQaoQr95uR0vZ7rqTHUEkMQVhvDtCQ4lSw8Zl9TuAqt5FTq50fHVL0wrMYR9nMHIigpPnpW0xAwpfhEqxOwF7qN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126843; c=relaxed/simple;
	bh=xf3DOQMVrG91iKbl7ipebCFVekmIKqtuQ81G7G/taU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AX3uFDt9XwzOtpMVvDPLUh0TuqvSD7eWDwiqCi1sAGjKAf98uy6BD/EgZ++aEWmaGz5/o74bmurBJdnhYLVg+I2W/ZXwX2AiWiyUXoXOMJNimZ0U27IFwUKeIEJvn8mYJrwct/JmASU/ENtqHFp8UodidEeZJ6sAbyf+d3Zh2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jA7KjOnd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c8b0f1b699so968024f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 06:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756126840; x=1756731640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0VK2T6V+Aj0ASKId11YflidkPTxQI3Y2JHVgkJXJUY=;
        b=jA7KjOndeExACc7SNVI2FNv3CzXKqGm/L2ZeQEo+2VyXbJEfySb6oLAQhopEytpuwi
         YllYjy3DU2YHtWOHM3iAz1g03YrqDRbKcz3l+owhbpa+44GX58q7ftWZvcYiQcVg/CDb
         VTbIRKpRo8o8WuAD0hAA2GBMx4rtET9lX4djVQPWQwrje7tJkb63rPjesGjSFH4oOXh9
         Oj2GKt5VwPZvR4vh+XfFZSVH6pC4ni5Kq0gltsGqHVwdMQ6OU8BzlQdntQg86girHsAy
         GXwOAG+RrB5TXrEcw75X5/RkS4O7OVj/d6qHGgNLAQafYR8NyaeZeYaZSORGrz+rrpuz
         yHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126840; x=1756731640;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0VK2T6V+Aj0ASKId11YflidkPTxQI3Y2JHVgkJXJUY=;
        b=Qtu1KW9pObH1XnMFLRdrKVcT2jodnAXXYa9tm5cm7iRGhnLG0zaZNpcNFhurLYUN/2
         ZqDvcTf6nxSpgYm4drQUNAlRe7AxJYb2vYVuDyybJ5V8f33YtoKqMDxpsAECz3uyENX2
         Mmh7hRWx2t62aP3GGPCvi6CcTBqMh3ren3ThhCjeFoiwD0Oaxx9c81BNS8HDQLi+U//T
         ST65rznBF7P2Dxr8v+KN20uZOjjk5hrxsdX8bHFGBXngBO4TRLunUgE5cgCANX42CeN1
         cpMyXfdd8JNuMDsuV8Wmrq0OD+1EesFS8+W6k2hextRuvRhsEz2Ct/1BHLvkWJa4Gh6B
         oV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSa7lQGstrOhsG3CBTaZT8oYiTlvAcPIaC2PQzvX4hxNqQfYgO/Zage5H8ZEspPAjEKPX9ig0F6Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVuM7tPV2plziiUb3PD+3V8uh5EtCs8W2KZpUQ6xtrFv2phJBg
	t12O1SvwM96acKayOl8j9me/WDSJy5pOa5DOWbPBUjeDkpJXPLPqRgTGLgnQ0L8l9U8=
X-Gm-Gg: ASbGnctQXd2PiJX864E1LPU16uC5R8/n+VcuZpms3K0qNLyuGpux6qjioypkSokwlHK
	N8stuXzYgb+l6bZdlT7DsO00ByTNXLz/hBy04mLCXJA3vMnn/OZOqJcQQxSsmNaHG4mRFa8WbDy
	TVKblTZpuy5ccD8FaKpXmlD3wqgH0P/cOdh0NUmWGr7Cfm6UgZiaGXsWVryqPy5L7LipWd5ZIYE
	6I63FKjowzklUHIZWVjKRr0yKgbVq7YoYWZiYu1DJr8KUhYl7LzCkExXDjomlVyi3LHy6BxYGIZ
	wEcyS055HloAnYNKnjda+bsyggkdppVjPooFYFdavMJsB60wkG5j3Q7BCZ2YDU6GoI7BxYVZpeQ
	SDfMzs2jENVVLir1TJTb66pN9OmAZMdscLlhcGQ==
X-Google-Smtp-Source: AGHT+IFKESXASQM+VKjSbNLcCSsxhZD3d1Nqd+0rOXEx7HybgyHMMHJuEk3zwIeA8eDEbkWtc7wtdQ==
X-Received: by 2002:a05:6000:2dc2:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3c5daefc754mr9642267f8f.23.1756126839858;
        Mon, 25 Aug 2025 06:00:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c7112129b9sm11538216f8f.34.2025.08.25.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:00:39 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:00:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Antoniu Miclaus <antoniu.miclaus@analog.com>,
	jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH v5 4/6] iio: adc: add ade9000 support
Message-ID: <202508250158.KQ6WdkKh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822160157.5092-5-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-add-IIO_ALTCURRENT-channel-type/20250823-001017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250822160157.5092-5-antoniu.miclaus%40analog.com
patch subject: [PATCH v5 4/6] iio: adc: add ade9000 support
config: arm-randconfig-r072-20250824 (https://download.01.org/0day-ci/archive/20250825/202508250158.KQ6WdkKh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508250158.KQ6WdkKh-lkp@intel.com/

New smatch warnings:
drivers/iio/adc/ade9000.c:1009 ade9000_irq1_thread() warn: right shifting more than type allows 16 vs 20
drivers/iio/adc/ade9000.c:1505 ade9000_write_event_config() error: uninitialized symbol 'tmp'.
drivers/iio/adc/ade9000.c:1554 ade9000_write_event_config() error: uninitialized symbol 'interrupts'.

Old smatch warnings:
drivers/iio/adc/ade9000.c:1018 ade9000_irq1_thread() warn: right shifting more than type allows 16 vs 20
drivers/iio/adc/ade9000.c:1027 ade9000_irq1_thread() warn: right shifting more than type allows 16 vs 20
drivers/iio/adc/ade9000.c:1036 ade9000_irq1_thread() warn: right shifting more than type allows 16 vs 20
drivers/iio/adc/ade9000.c:1045 ade9000_irq1_thread() warn: right shifting more than type allows 16 vs 20
drivers/iio/adc/ade9000.c:1054 ade9000_irq1_thread() warn: right shifting more than type allows 16 vs 20

vim +1009 drivers/iio/adc/ade9000.c

b695e630eecec70 Antoniu Miclaus 2025-08-22   998  		case ADE9000_ST1_ZXIC_BIT:
b695e630eecec70 Antoniu Miclaus 2025-08-22   999  			iio_push_event(indio_dev,
b695e630eecec70 Antoniu Miclaus 2025-08-22  1000  				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
b695e630eecec70 Antoniu Miclaus 2025-08-22  1001  							    ADE9000_ST1_ZXIC_BIT,
b695e630eecec70 Antoniu Miclaus 2025-08-22  1002  							    IIO_EV_TYPE_THRESH,
b695e630eecec70 Antoniu Miclaus 2025-08-22  1003  							    IIO_EV_DIR_EITHER),
b695e630eecec70 Antoniu Miclaus 2025-08-22  1004  				       timestamp);
b695e630eecec70 Antoniu Miclaus 2025-08-22  1005  			handled_irq |= ADE9000_ST1_ZXIC_BIT;
b695e630eecec70 Antoniu Miclaus 2025-08-22  1006  			break;
b695e630eecec70 Antoniu Miclaus 2025-08-22  1007  		case ADE9000_ST1_SWELLA_BIT:
b695e630eecec70 Antoniu Miclaus 2025-08-22  1008  			iio_push_event(indio_dev,
b695e630eecec70 Antoniu Miclaus 2025-08-22 @1009  				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
b695e630eecec70 Antoniu Miclaus 2025-08-22  1010  							    ADE9000_ST1_SWELLA_BIT >> 20,

This is a kind of macro expansion bug:

include/linux/iio/events.h
    27  #define _IIO_EVENT_CODE(chan_type, diff, modifier, direction,           \
    28                          type, chan, chan1, chan2)                       \
    29          (((u64)type << 56) | ((u64)diff << 55) |                        \
    30           ((u64)direction << 48) | ((u64)modifier << 40) |               \
    31           ((u64)chan_type << 32) | (((u16)chan2) << 16) | ((u16)chan1) | \
    32           ((u16)chan))

There should be parenthese around "chan" on line 32.

	((u16)(chan)))

Otherwise it's a precendent bug and  we end up doing the cast before we
do the ">> 20".  Probably around the others as well?  Probably best if
someone tests this.


drivers/iio/adc/ade9000.c
  1425  static int ade9000_write_event_config(struct iio_dev *indio_dev,
  1426                                        const struct iio_chan_spec *chan,
  1427                                        enum iio_event_type type,
  1428                                        enum iio_event_direction dir,
  1429                                        bool state)
  1430  {
  1431          struct ade9000_state *st = iio_priv(indio_dev);
  1432          u32 interrupts, tmp;
  1433          int ret;
  1434  
  1435          /* Clear all pending events in STATUS1 register (write 1 to clear) */
  1436          ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
  1437          if (ret)
  1438                  return ret;
  1439  
  1440          if (type == IIO_EV_TYPE_MAG) {
  1441                  ret = regmap_update_bits(st->regmap, ADE9000_REG_STATUS0,
  1442                                           ADE9000_ST0_EGYRDY, ADE9000_ST0_EGYRDY);
  1443                  if (ret)
  1444                          return ret;
  1445                  return regmap_update_bits(st->regmap, ADE9000_REG_MASK0,
  1446                                           ADE9000_ST0_EGYRDY,
  1447                                           state ? ADE9000_ST1_SEQERR_BIT : 0);
  1448          }
  1449  
  1450          if (type == IIO_EV_TYPE_CHANGE)
  1451                  return regmap_update_bits(st->regmap, ADE9000_REG_MASK1,
  1452                                           ADE9000_ST1_SEQERR_BIT,
  1453                                           state ? ADE9000_ST1_SEQERR_BIT : 0);
  1454  
  1455          if (dir == IIO_EV_DIR_EITHER) {
  1456                  static const struct {
  1457                          u32 irq;
  1458                          u32 wfb_trg;
  1459                  } trig_arr[6] = {
  1460                          {
  1461                                  .irq = ADE9000_ST1_ZXVA_BIT,
  1462                                  .wfb_trg = ADE9000_WFB_TRG_ZXVA_BIT
  1463                          }, {
  1464                                  .irq = ADE9000_ST1_ZXIA_BIT,
  1465                                  .wfb_trg = ADE9000_WFB_TRG_ZXIA_BIT
  1466                          }, {
  1467                                  .irq = ADE9000_ST1_ZXVB_BIT,
  1468                                  .wfb_trg = ADE9000_WFB_TRG_ZXVB_BIT
  1469                          }, {
  1470                                  .irq = ADE9000_ST1_ZXIB_BIT,
  1471                                  .wfb_trg = ADE9000_WFB_TRG_ZXIB_BIT
  1472                          }, {
  1473                                  .irq = ADE9000_ST1_ZXVC_BIT,
  1474                                  .wfb_trg = ADE9000_WFB_TRG_ZXVC_BIT
  1475                          }, {
  1476                                  .irq = ADE9000_ST1_ZXIC_BIT,
  1477                                  .wfb_trg = ADE9000_WFB_TRG_ZXIC_BIT
  1478                          },
  1479                  };
  1480                  if (state) {
  1481                          interrupts |= trig_arr[chan->channel * 2 + chan->type].irq;
  1482                          st->wfb_trg |= trig_arr[chan->channel * 2 + chan->type].wfb_trg;
  1483                  } else {
  1484                          interrupts &= ~trig_arr[chan->channel * 2 + chan->type].irq;
  1485                          st->wfb_trg &= ~trig_arr[chan->channel * 2 + chan->type].wfb_trg;
  1486                  }
  1487          }
  1488  
  1489          if (dir == IIO_EV_DIR_NONE) {
  1490                  switch (chan->channel) {
  1491                  case ADE9000_PHASE_A_NR:
  1492                          tmp |= ADE9000_ST1_ZXTOVA_BIT;

You can |= an uninitialized variable.

  1493                          break;
  1494                  case ADE9000_PHASE_B_NR:
  1495                          tmp |= ADE9000_ST1_ZXTOVB_BIT;
  1496                          break;
  1497                  case ADE9000_PHASE_C_NR:
  1498                          tmp |= ADE9000_ST1_ZXTOVC_BIT;
  1499                          break;
  1500                  default:
  1501                          break;
  1502                  }
  1503  
  1504                  if (state)
  1505                          interrupts |= tmp;

Same.

  1506                  else
  1507                          interrupts &= ~tmp;
  1508          } else if (dir == IIO_EV_DIR_RISING) {
  1509                  switch (chan->channel) {
  1510                  case ADE9000_PHASE_A_NR:
  1511                          tmp |= ADE9000_ST1_SWELLA_BIT;
  1512                          break;
  1513                  case ADE9000_PHASE_B_NR:
  1514                          tmp |= ADE9000_ST1_SWELLB_BIT;
  1515                          break;
  1516                  case ADE9000_PHASE_C_NR:
  1517                          tmp |= ADE9000_ST1_SWELLC_BIT;
  1518                          break;
  1519                  default:
  1520                          break;
  1521                  }
  1522  
  1523                  if (state) {
  1524                          interrupts |= tmp;
  1525                          st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
  1526                  } else {
  1527                          interrupts &= ~tmp;
  1528                          st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
  1529                  }
  1530          } else if (dir == IIO_EV_DIR_FALLING) {
  1531                  switch (chan->channel) {
  1532                  case ADE9000_PHASE_A_NR:
  1533                          tmp |= ADE9000_ST1_DIPA_BIT;
  1534                          break;
  1535                  case ADE9000_PHASE_B_NR:
  1536                          tmp |= ADE9000_ST1_DIPB_BIT;
  1537                          break;
  1538                  case ADE9000_PHASE_C_NR:
  1539                          tmp |= ADE9000_ST1_DIPC_BIT;
  1540                          break;
  1541                  default:
  1542                          break;
  1543                  }
  1544  
  1545                  if (state) {
  1546                          interrupts |= tmp;
  1547                          st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
  1548                  } else {
  1549                          interrupts &= ~tmp;
  1550                          st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
  1551                  }
  1552          }
  1553  
  1554          return regmap_update_bits(st->regmap, ADE9000_REG_MASK1, interrupts,
  1555                                    interrupts);
  1556  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


