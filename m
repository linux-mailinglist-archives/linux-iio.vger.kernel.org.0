Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E722F3B6F7F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jun 2021 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhF2IgM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Jun 2021 04:36:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16112 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232499AbhF2IgM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jun 2021 04:36:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T8V27u007665;
        Tue, 29 Jun 2021 08:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=YDAMznlUlqyQEk43QsFwnfvacbaf5yTFCKvZVEDsxuI=;
 b=f0OxpOL2p1DQ1cADs0TpHJ7Lm8Y6Ugms/mfzFXKPex2rj29Bu51vcdRMI9Oypmyz6fRG
 1Rn8VlDqvDjz7x4lSA7mP2XEW18hcd0gtxWG5ZJqZRXdiColn/+s+MqtHHtToFKcOIov
 Px0W3NOHFEsjia5OeOytcXnI9CINqUvLVoH2DakcRtG37es5cuN0/jP43PZrlYjepo28
 ehwOIXXWNo31PdYFAxqqgPT5ScIqucIUTCuW0S2wenvPJgJbsSafuL6Vzw3lMmA8VA5M
 0S79GnpCU2vmDHZAJ3Au2nOjRAYHe8O0XyeGg0LGq6IIiaH8Q3bnsYD78hpv1SRJgLvk kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6y3jwqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 08:33:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15T8Pcn0003007;
        Tue, 29 Jun 2021 08:33:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 39dsbx8yf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 08:33:13 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15T8XDuH029793;
        Tue, 29 Jun 2021 08:33:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 39dsbx8yes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 08:33:12 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15T8X86R027377;
        Tue, 29 Jun 2021 08:33:08 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jun 2021 01:33:08 -0700
Date:   Tue, 29 Jun 2021 11:32:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        git-dev@xilinx.com, michal.simek@xilinx.com, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
Message-ID: <202106290536.M75RUmJ1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624182939.12881-3-anand.ashok.dumbre@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: YqfZhSk_QRHd-mgwQtNMo2UcZm1eXOG8
X-Proofpoint-ORIG-GUID: YqfZhSk_QRHd-mgwQtNMo2UcZm1eXOG8
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Anand,

url:    https://github.com/0day-ci/linux/commits/Anand-Ashok-Dumbre/Add-Xilinx-AMS-Driver/20210625-023047
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: microblaze-randconfig-m031-20210628 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iio/adc/xilinx-ams.c:406 ams_enable_channel_sequence() warn: should '(((1))) << (indio_dev->channels[i]->scan_index)' be a 64 bit type?
drivers/iio/adc/xilinx-ams.c:1126 ams_init_module() error: uninitialized symbol 'chan_node'.

vim +406 drivers/iio/adc/xilinx-ams.c

fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  392  static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  393  {
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  394  	int i;
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  395  	unsigned long long scan_mask;
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  396  	struct ams *ams = iio_priv(indio_dev);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  397  
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  398  	/*
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  399  	 * Enable channel sequence. First 22 bits of scan_mask represent
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  400  	 * PS channels, and next remaining bits represent PL channels.
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  401  	 */
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  402  
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  403  	/* Run calibration of PS & PL as part of the sequence */
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  404  	scan_mask = 0x1 | BIT(AMS_PS_SEQ_MAX);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  405  	for (i = 0; i < indio_dev->num_channels; i++)
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24 @406  		scan_mask |= BIT(indio_dev->channels[i].scan_index);

Since scan_mask is ull should we use BIT_ULL() instead of BIT()?

(I haven't look at the context outside of this email so I don't know
the value of indio_dev->num_channels).

fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  407  
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  408  	if (ams->ps_base) {
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  409  		/* put sysmon in a soft reset to change the sequence */
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  410  		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  411  				  AMS_CONF1_SEQ_DEFAULT);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  412  
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  413  		/* configure basic channels */
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  414  		writel(scan_mask & AMS_REG_SEQ0_MASK,
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  415  		       ams->ps_base + AMS_REG_SEQ_CH0);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  416  		writel(AMS_REG_SEQ2_MASK &
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  417  		       (scan_mask >> AMS_REG_SEQ2_MASK_SHIFT),
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  418  		       ams->ps_base + AMS_REG_SEQ_CH2);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  419  
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  420  		/* set continuous sequence mode */
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  421  		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  422  				  AMS_CONF1_SEQ_CONTINUOUS);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  423  	}
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  424  
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  425  	if (ams->pl_base) {
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  426  		/* put sysmon in a soft reset to change the sequence */
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  427  		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  428  				  AMS_CONF1_SEQ_DEFAULT);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  429  
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  430  		/* configure basic channels */
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  431  		scan_mask = scan_mask >> AMS_PS_SEQ_MAX;
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  432  		writel(scan_mask & AMS_REG_SEQ0_MASK,
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  433  		       ams->pl_base + AMS_REG_SEQ_CH0);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  434  		writel(AMS_REG_SEQ2_MASK &
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  435  		       (scan_mask >> AMS_REG_SEQ2_MASK_SHIFT),
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  436  		       ams->pl_base + AMS_REG_SEQ_CH2);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  437  		writel(AMS_REG_SEQ1_MASK &
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  438  		       (scan_mask >> AMS_REG_SEQ1_MASK_SHIFT),
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  439  		       ams->pl_base + AMS_REG_SEQ_CH1);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  440  
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  441  		/* set continuous sequence mode */
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  442  		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  443  				  AMS_CONF1_SEQ_CONTINUOUS);
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  444  	}
fa0ea7aaf7a9bf Anand Ashok Dumbre 2021-06-24  445  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

