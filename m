Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ADE3BA93D
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhGCPce (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 11:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhGCPce (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 11:32:34 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A0C061762;
        Sat,  3 Jul 2021 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QABguMzP1/VumBvVHw70jOoK+BIUazJP6EF/sOlcL/c=; b=npD23N6p0GJrBNRRLPAmj8uzUr
        URbfIkwPhkAPTv8LVCXhfP2Q8vAHRrTc3XepN21DEU/vL+SJSxxtQabOZHYLgaI1bA9JVkJObC+A5
        7oIUx2KTa5jNqn/tQi8Xb58etTlKeW/eQWMA3kRJolh9qp50PPC24PcTJ9jT1d9Nwryk=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lzhaW-000084-5L; Sat, 03 Jul 2021 17:29:48 +0200
Date:   Sat, 3 Jul 2021 17:29:47 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     kernel test robot <lkp@intel.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        lars@metafoo.de, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH 4/4] power: supply: rn5t618: Add voltage_now property
Message-ID: <20210703172947.60e456a1@aktux>
In-Reply-To: <202107032203.CYwEkIW0-lkp@intel.com>
References: <20210703084224.31623-5-andreas@kemnade.info>
        <202107032203.CYwEkIW0-lkp@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

oh, I forgot to add some depends IIO in the Makefile. I will wait some
days for human reviewers before spinning a v2.

Regards,
Andreas

On Sat, 3 Jul 2021 22:35:27 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Andreas,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on power-supply/for-next]
> [also build test ERROR on next-20210701]
> [cannot apply to lee-mfd/for-mfd-next iio/togreg robh/for-next v5.13]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andreas-Kemnade/mfd-rn5t618-Extend-ADC-support/20210703-164312
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
> config: i386-randconfig-m031-20210702 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/99953e2eb9d653eb8bc74eb482cef7c9fb4e69d7
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andreas-Kemnade/mfd-rn5t618-Extend-ADC-support/20210703-164312
>         git checkout 99953e2eb9d653eb8bc74eb482cef7c9fb4e69d7
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "devm_iio_channel_get" [drivers/power/supply/rn5t618_power.ko] undefined!
> >> ERROR: modpost: "iio_read_channel_processed" [drivers/power/supply/rn5t618_power.ko] undefined!  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

