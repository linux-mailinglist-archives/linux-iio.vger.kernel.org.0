Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5041F88E3
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgFNNPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgFNNPv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:15:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14CD2206D7;
        Sun, 14 Jun 2020 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592140550;
        bh=WbHgzaZ0tGmUeII0qMtwKp7soUXZ40jam2hrCr4ruBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ah/bS4UrgBjVM4vR6aG4D0tFb3+RytJ8FJdYP5vvl4dS7QfHay41vHskJvD4rfONm
         u/lsPGtl0L8GDET5GDfuCU1iEy7dhhm1mu08LwICCyAHZ0Cf40GJuYfVyCq9CQW4hS
         0AFAWLHuHoQV3+SLRlZCPa7EWvwumapTu+vSS8aM=
Date:   Sun, 14 Jun 2020 14:15:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, andy.shevchenko@gmail.com, pmeerw@pmeerw.net
Subject: Re: [PATCH v5 1/4] iio: chemical: scd30: add core driver
Message-ID: <20200614141546.7a1af2f5@archlinux>
In-Reply-To: <202006090426.ENCJHJ1n%lkp@intel.com>
References: <20200607175812.95777-2-tomasz.duszynski@octakon.com>
        <202006090426.ENCJHJ1n%lkp@intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Jun 2020 04:18:56 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Tomasz,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on iio/togreg]
> [also build test WARNING on robh/for-next linux/master v5.7]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Tomasz-Duszynski/Add-support-for-SCD30-sensor/20200608-020304
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I'll tidy this up whilst applying assuming nothing else comes up.
No comment on it's validity as a warning, but in my view it
is always squashing warnings to keep the noise low for any
more useful ones (as long as it's not too costly).

Jonathan

> 
> 
> cppcheck warnings: (new ones prefixed by >>)
> 
> >> drivers/iio/chemical/scd30_core.c:93:31: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]  
>         sign = float32 & BIT(31) ? -1 : 1,
>                                  ^
> 
> vim +93 drivers/iio/chemical/scd30_core.c
> 
>     87	
>     88	/* simplified float to fixed point conversion with a scaling factor of 0.01 */
>     89	static int scd30_float_to_fp(int float32)
>     90	{
>     91		int fraction, shift,
>     92		    mantissa = float32 & GENMASK(22, 0),
>   > 93		    sign = float32 & BIT(31) ? -1 : 1,  
>     94		    exp = (float32 & ~BIT(31)) >> 23;
>     95	
>     96		/* special case 0 */
>     97		if (!exp && !mantissa)
>     98			return 0;
>     99	
>    100		exp -= 127;
>    101		if (exp < 0) {
>    102			exp = -exp;
>    103			/* return values ranging from 1 to 99 */
>    104			return sign * ((((BIT(23) + mantissa) * 100) >> 23) >> exp);
>    105		}
>    106	
>    107		/* return values starting at 100 */
>    108		shift = 23 - exp;
>    109		float32 = BIT(exp) + (mantissa >> shift);
>    110		fraction = mantissa & GENMASK(shift - 1, 0);
>    111	
>    112		return sign * (float32 * 100 + ((fraction * 100) >> shift));
>    113	}
>    114	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

