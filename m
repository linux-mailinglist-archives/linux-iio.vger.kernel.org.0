Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C540E74848E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jul 2023 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjGENEF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jul 2023 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjGENEE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jul 2023 09:04:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF21E12A
        for <linux-iio@vger.kernel.org>; Wed,  5 Jul 2023 06:04:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31441bc0092so1639436f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Jul 2023 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688562241; x=1691154241;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRtlL5U9YZfE/0Bf1WN6Cfic6tkO5XVWWjm7V1kAKkU=;
        b=nRbS2NXJ4X3I35gJinID6AsJpOXOQFJoD1j7U5L3JjrAA/ZomGt9xPfCTAPANOPUQh
         qANOv1sIyNk5fuW1OMQLemYC3lX3Fqkhs2xbzWU5WdqrQS1nud6gHvpPfFAuN1PgYHP+
         2u4uQWV6g6grNexVG90Zblq7O6UJoeTQwbbHAdUhm9sXVPiuPZS/69yni5CXTzciP577
         5YS7WZIoGrKJlGiG92ad/0jzqrzZanEpMs0RtOTR3rTHIGWw/Vq4qcsaEMbjsf0BCnGZ
         qfjW2hH4Lj+xLC+6l4ctAoUbK3ujUkdwIfZ481rPdnkizLT9soCqWNbpDv5ifMDsg1L6
         tisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688562241; x=1691154241;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRtlL5U9YZfE/0Bf1WN6Cfic6tkO5XVWWjm7V1kAKkU=;
        b=bJX8Isuxe8/uLnJc9M1oLX0lqzKMHL5ZzltUqoWoURKMSEVrXwe9za9UeYU73kgPrF
         6baZ+Mcy2xUzh4L2cE+d82c4bRgc8DeTh7NGYLEpF+HrMcFRpz2TkW9X273y1hvqliSI
         IeAobNZBjXIW29J2v5tJoJWJ579tYbjIEmpchXEDX29DuIL85IPpIxYqR/BjHAFon1Hm
         QwNPSDwpGuqB8cNXJQ+vY9YNinq1AxwcR3+SpHj0s0Bom3Hlklmt0Z1+foq+ZPAkRDBL
         TkCQM8BvpAlodplmQgban5IRN6j4TJkzoIh0fVUj23B9wvP6iQXTSSRu8IVThy7G8if8
         UQdw==
X-Gm-Message-State: ABy/qLYsctXJQfptQCoYp3mc4t64E+OUgcfPCWnAMk9h5N12jjDlTk1G
        kN+9QTpNI5T9V2n0gUamT1KESsbpvaIGL1ljuVQ=
X-Google-Smtp-Source: APBJJlH80m+8XxUMjAWGnMCnWL6lwxkrZFfYDEIqxKuoQsqtUJlKGi7zjhLA4lCOchb7t1j0ITkJAw==
X-Received: by 2002:adf:f6d1:0:b0:313:f7a1:3d92 with SMTP id y17-20020adff6d1000000b00313f7a13d92mr12756274wrp.66.1688562241301;
        Wed, 05 Jul 2023 06:04:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020adff00f000000b00314315071bbsm10336087wro.38.2023.07.05.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:03:59 -0700 (PDT)
Date:   Wed, 5 Jul 2023 16:03:56 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Roan van Dijk <roan@protonic.nl>,
        jic23@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        roan@protonic.nl
Subject: Re: [PATCH] iio: chemical: scd4x: Add pressure compensation
Message-ID: <2cada93d-239f-404b-a69c-ba23dd4c48a8@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704084706.370637-1-roan@protonic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Roan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roan-van-Dijk/iio-chemical-scd4x-Add-pressure-compensation/20230704-170621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230704084706.370637-1-roan%40protonic.nl
patch subject: [PATCH] iio: chemical: scd4x: Add pressure compensation
config: x86_64-randconfig-m001-20230705 (https://download.01.org/0day-ci/archive/20230705/202307052018.7DV5CAOH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230705/202307052018.7DV5CAOH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307052018.7DV5CAOH-lkp@intel.com/

smatch warnings:
drivers/iio/chemical/scd4x.c:385 scd4x_read_raw() error: uninitialized symbol 'ret'.
drivers/iio/chemical/scd4x.c:388 scd4x_read_raw() error: uninitialized symbol 'tmp'.

vim +/ret +385 drivers/iio/chemical/scd4x.c

49d22b695cbb69 Roan van Dijk 2021-10-08  335  static int scd4x_read_raw(struct iio_dev *indio_dev,
49d22b695cbb69 Roan van Dijk 2021-10-08  336  			struct iio_chan_spec const *chan, int *val,
49d22b695cbb69 Roan van Dijk 2021-10-08  337  			int *val2, long mask)
49d22b695cbb69 Roan van Dijk 2021-10-08  338  {
49d22b695cbb69 Roan van Dijk 2021-10-08  339  	struct scd4x_state *state = iio_priv(indio_dev);
49d22b695cbb69 Roan van Dijk 2021-10-08  340  	int ret;
49d22b695cbb69 Roan van Dijk 2021-10-08  341  	__be16 tmp;
49d22b695cbb69 Roan van Dijk 2021-10-08  342  
49d22b695cbb69 Roan van Dijk 2021-10-08  343  	switch (mask) {
49d22b695cbb69 Roan van Dijk 2021-10-08  344  	case IIO_CHAN_INFO_RAW:
49d22b695cbb69 Roan van Dijk 2021-10-08  345  		ret = iio_device_claim_direct_mode(indio_dev);
49d22b695cbb69 Roan van Dijk 2021-10-08  346  		if (ret)
49d22b695cbb69 Roan van Dijk 2021-10-08  347  			return ret;
49d22b695cbb69 Roan van Dijk 2021-10-08  348  
49d22b695cbb69 Roan van Dijk 2021-10-08  349  		mutex_lock(&state->lock);
49d22b695cbb69 Roan van Dijk 2021-10-08  350  		ret = scd4x_read_channel(state, chan->address);
49d22b695cbb69 Roan van Dijk 2021-10-08  351  		mutex_unlock(&state->lock);
49d22b695cbb69 Roan van Dijk 2021-10-08  352  
49d22b695cbb69 Roan van Dijk 2021-10-08  353  		iio_device_release_direct_mode(indio_dev);
49d22b695cbb69 Roan van Dijk 2021-10-08  354  		if (ret < 0)
49d22b695cbb69 Roan van Dijk 2021-10-08  355  			return ret;
49d22b695cbb69 Roan van Dijk 2021-10-08  356  
49d22b695cbb69 Roan van Dijk 2021-10-08  357  		*val = ret;
49d22b695cbb69 Roan van Dijk 2021-10-08  358  		return IIO_VAL_INT;
49d22b695cbb69 Roan van Dijk 2021-10-08  359  	case IIO_CHAN_INFO_SCALE:
e46e2512ac84bd Roan van Dijk 2021-10-21  360  		if (chan->type == IIO_CONCENTRATION) {
e46e2512ac84bd Roan van Dijk 2021-10-21  361  			*val = 0;
e46e2512ac84bd Roan van Dijk 2021-10-21  362  			*val2 = 100;
e46e2512ac84bd Roan van Dijk 2021-10-21  363  			return IIO_VAL_INT_PLUS_MICRO;
e46e2512ac84bd Roan van Dijk 2021-10-21  364  		} else if (chan->type == IIO_TEMP) {
49d22b695cbb69 Roan van Dijk 2021-10-08  365  			*val = 175000;
49d22b695cbb69 Roan van Dijk 2021-10-08  366  			*val2 = 65536;
49d22b695cbb69 Roan van Dijk 2021-10-08  367  			return IIO_VAL_FRACTIONAL;
49d22b695cbb69 Roan van Dijk 2021-10-08  368  		} else if (chan->type == IIO_HUMIDITYRELATIVE) {
49d22b695cbb69 Roan van Dijk 2021-10-08  369  			*val = 100000;
49d22b695cbb69 Roan van Dijk 2021-10-08  370  			*val2 = 65536;
49d22b695cbb69 Roan van Dijk 2021-10-08  371  			return IIO_VAL_FRACTIONAL;
49d22b695cbb69 Roan van Dijk 2021-10-08  372  		}
49d22b695cbb69 Roan van Dijk 2021-10-08  373  		return -EINVAL;
49d22b695cbb69 Roan van Dijk 2021-10-08  374  	case IIO_CHAN_INFO_OFFSET:
49d22b695cbb69 Roan van Dijk 2021-10-08  375  		*val = -16852;
49d22b695cbb69 Roan van Dijk 2021-10-08  376  		*val2 = 114286;
49d22b695cbb69 Roan van Dijk 2021-10-08  377  		return IIO_VAL_INT_PLUS_MICRO;
49d22b695cbb69 Roan van Dijk 2021-10-08  378  	case IIO_CHAN_INFO_CALIBBIAS:
49d22b695cbb69 Roan van Dijk 2021-10-08  379  		mutex_lock(&state->lock);
8e4a309948cffe Roan van Dijk 2023-07-04  380  		if (chan->type == IIO_TEMP)
49d22b695cbb69 Roan van Dijk 2021-10-08  381  			ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, sizeof(tmp));
8e4a309948cffe Roan van Dijk 2023-07-04  382  		else if (chan->type == IIO_PRESSURE)
8e4a309948cffe Roan van Dijk 2023-07-04  383  			ret = scd4x_read(state, CMD_GET_AMB_PRESSURE, &tmp, sizeof(tmp));

ret is uninitialized if type != IIO_TEMP and != IIO_PRESSURE.

49d22b695cbb69 Roan van Dijk 2021-10-08  384  		mutex_unlock(&state->lock);
49d22b695cbb69 Roan van Dijk 2021-10-08 @385  		if (ret)
49d22b695cbb69 Roan van Dijk 2021-10-08  386  			return ret;
49d22b695cbb69 Roan van Dijk 2021-10-08  387  
49d22b695cbb69 Roan van Dijk 2021-10-08 @388  		*val = be16_to_cpu(tmp);
49d22b695cbb69 Roan van Dijk 2021-10-08  389  
49d22b695cbb69 Roan van Dijk 2021-10-08  390  		return IIO_VAL_INT;
49d22b695cbb69 Roan van Dijk 2021-10-08  391  	default:
49d22b695cbb69 Roan van Dijk 2021-10-08  392  		return -EINVAL;
49d22b695cbb69 Roan van Dijk 2021-10-08  393  	}
49d22b695cbb69 Roan van Dijk 2021-10-08  394  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

