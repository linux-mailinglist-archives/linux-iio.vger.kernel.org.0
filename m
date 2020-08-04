Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49823B48B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 07:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHDFpf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 01:45:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:2057 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgHDFpf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Aug 2020 01:45:35 -0400
IronPort-SDR: CuVWNq0V8bD+8US82Tfs9mjJsIIXykP09glSNS3jt8tk/itAoHd6U9S7BG0h0VkymTuy4DF9ao
 UDFss+gzrIbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="131822277"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="gz'50?scan'50,208,50";a="131822277"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 22:45:31 -0700
IronPort-SDR: II2nejDkhSph6DiWHOJQVdrMOV16ivKcNU/3hF7S0GM6gpgomMVogVYZkfdPNb6d/uM5sSr3na
 kj1nKY+x8tig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="gz'50?scan'50,208,50";a="366770831"
Received: from lkp-server02.sh.intel.com (HELO 84ccfe698a63) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2020 22:45:28 -0700
Received: from kbuild by 84ccfe698a63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2plP-0000S4-UA; Tue, 04 Aug 2020 05:45:27 +0000
Date:   Tue, 4 Aug 2020 13:43:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: Re: [PATCH] iio:temperature:mlx90632: Reduce number of equal
 calulcations
Message-ID: <202008041325.ANQkrdbK%lkp@intel.com>
References: <20200803151656.332559-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20200803151656.332559-1-cmo@melexis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Crt,

I love your patch! Yet something to improve:

[auto build test ERROR on iio/togreg]
[also build test ERROR on v5.8 next-20200803]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Crt-Mori/iio-temperature-mlx90632-Reduce-number-of-equal-calulcations/20200803-231936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-randconfig-a001-20200803 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 4ffa6a27aca17fe88fa6bdd605b198df6632a570)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/temperature/mlx90632.c:381:40: error: redefinition of 'TAdut4'
           s64 calcedKsTO, calcedKsTA, ir_Alpha, TAdut4, Alpha_corr;
                                                 ^
   drivers/iio/temperature/mlx90632.c:377:28: note: previous definition is here
                                                  s64 TAdut, s64 TAdut4, s32 Fa, s32 Fb,
                                                                 ^
>> drivers/iio/temperature/mlx90632.c:412:2: error: use of undeclared identifier 'TAdut4'; did you mean 'TAdut'?
           TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
           ^~~~~~
           TAdut
   drivers/iio/temperature/mlx90632.c:405:17: note: 'TAdut' declared here
           s64 kTA, kTA0, TAdut;
                          ^
   drivers/iio/temperature/mlx90632.c:419:67: error: use of undeclared identifier 'TAdut4'; did you mean 'TAdut'?
                   temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TAdut4,
                                                                                   ^~~~~~
                                                                                   TAdut
   drivers/iio/temperature/mlx90632.c:405:17: note: 'TAdut' declared here
           s64 kTA, kTA0, TAdut;
                          ^
   3 errors generated.

vim +/TAdut4 +381 drivers/iio/temperature/mlx90632.c

c87742abfc80b3 Crt Mori 2018-01-11  375  
c87742abfc80b3 Crt Mori 2018-01-11  376  static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
dd5b04efd05f22 Crt Mori 2020-08-03  377  					       s64 TAdut, s64 TAdut4, s32 Fa, s32 Fb,
c87742abfc80b3 Crt Mori 2018-01-11  378  					       s32 Ga, s16 Ha, s16 Hb,
c87742abfc80b3 Crt Mori 2018-01-11  379  					       u16 emissivity)
c87742abfc80b3 Crt Mori 2018-01-11  380  {
c87742abfc80b3 Crt Mori 2018-01-11 @381  	s64 calcedKsTO, calcedKsTA, ir_Alpha, TAdut4, Alpha_corr;
c87742abfc80b3 Crt Mori 2018-01-11  382  	s64 Ha_customer, Hb_customer;
c87742abfc80b3 Crt Mori 2018-01-11  383  
dd5b04efd05f22 Crt Mori 2020-08-03  384  	Ha_customer = div64_s64((s64)Ha * 1000000LL, 16384);
dd5b04efd05f22 Crt Mori 2020-08-03  385  	Hb_customer = div64_s64((s64)Hb * 100, 1024);
c87742abfc80b3 Crt Mori 2018-01-11  386  
dd5b04efd05f22 Crt Mori 2020-08-03  387  	calcedKsTO = div64_s64((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
dd5b04efd05f22 Crt Mori 2020-08-03  388  				     * 1000LL), 68719476736);
dd5b04efd05f22 Crt Mori 2020-08-03  389  	calcedKsTA = div64_s64((s64)(Fb * (TAdut - 25 * 1000000LL)), 68719476736);
dd5b04efd05f22 Crt Mori 2020-08-03  390  	Alpha_corr = div64_s64(div64_s64((s64)(Fa * 10000000000LL), 70368744177664)
dd5b04efd05f22 Crt Mori 2020-08-03  391  			       * Ha_customer, 1000LL);
c87742abfc80b3 Crt Mori 2018-01-11  392  	Alpha_corr *= ((s64)(1 * 1000000LL + calcedKsTO + calcedKsTA));
c87742abfc80b3 Crt Mori 2018-01-11  393  	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
c87742abfc80b3 Crt Mori 2018-01-11  394  	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
c87742abfc80b3 Crt Mori 2018-01-11  395  	ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
c87742abfc80b3 Crt Mori 2018-01-11  396  
c87742abfc80b3 Crt Mori 2018-01-11  397  	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
c87742abfc80b3 Crt Mori 2018-01-11  398  		- 27315 - Hb_customer) * 10;
c87742abfc80b3 Crt Mori 2018-01-11  399  }
c87742abfc80b3 Crt Mori 2018-01-11  400  
c87742abfc80b3 Crt Mori 2018-01-11  401  static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
c87742abfc80b3 Crt Mori 2018-01-11  402  				     s32 Fa, s32 Fb, s32 Ga, s16 Ha, s16 Hb,
c87742abfc80b3 Crt Mori 2018-01-11  403  				     u16 tmp_emi)
c87742abfc80b3 Crt Mori 2018-01-11  404  {
c87742abfc80b3 Crt Mori 2018-01-11  405  	s64 kTA, kTA0, TAdut;
c87742abfc80b3 Crt Mori 2018-01-11  406  	s64 temp = 25000;
c87742abfc80b3 Crt Mori 2018-01-11  407  	s8 i;
c87742abfc80b3 Crt Mori 2018-01-11  408  
c87742abfc80b3 Crt Mori 2018-01-11  409  	kTA = (Ea * 1000LL) >> 16LL;
c87742abfc80b3 Crt Mori 2018-01-11  410  	kTA0 = (Eb * 1000LL) >> 8LL;
c87742abfc80b3 Crt Mori 2018-01-11  411  	TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
dd5b04efd05f22 Crt Mori 2020-08-03 @412  	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
dd5b04efd05f22 Crt Mori 2020-08-03  413  		(div64_s64(TAdut, 10000LL) + 27315) *
dd5b04efd05f22 Crt Mori 2020-08-03  414  		(div64_s64(TAdut, 10000LL)  + 27315) *
dd5b04efd05f22 Crt Mori 2020-08-03  415  		(div64_s64(TAdut, 10000LL) + 27315);
c87742abfc80b3 Crt Mori 2018-01-11  416  
c87742abfc80b3 Crt Mori 2018-01-11  417  	/* Iterations of calculation as described in datasheet */
c87742abfc80b3 Crt Mori 2018-01-11  418  	for (i = 0; i < 5; ++i) {
dd5b04efd05f22 Crt Mori 2020-08-03  419  		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TAdut4,
c87742abfc80b3 Crt Mori 2018-01-11  420  							   Fa, Fb, Ga, Ha, Hb,
c87742abfc80b3 Crt Mori 2018-01-11  421  							   tmp_emi);
c87742abfc80b3 Crt Mori 2018-01-11  422  	}
c87742abfc80b3 Crt Mori 2018-01-11  423  	return temp;
c87742abfc80b3 Crt Mori 2018-01-11  424  }
c87742abfc80b3 Crt Mori 2018-01-11  425  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bp/iNruPH9dso1Pn--
