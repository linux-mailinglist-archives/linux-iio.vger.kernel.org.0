Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA85A5548
	for <lists+linux-iio@lfdr.de>; Mon, 29 Aug 2022 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiH2UEx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Aug 2022 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH2UEw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2022 16:04:52 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12511141;
        Mon, 29 Aug 2022 13:04:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id y17so2295qvr.5;
        Mon, 29 Aug 2022 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VrcaK2MkLHXfaL+K6GMnNADLdyI+Pp63vvXW1LBLvKg=;
        b=TcsnXDkAJmHdPZiZnWETXjHQtC20zvd3rr96MTigBclTVJFZASY8Ryyg14ah0BHoXG
         DVOLWUjU+rzpoMXhWxdYSVGx/FGlZkGNHG1+ob7DVKMEPf122kM7dN4Zvb4mbpp57ngb
         iWapM6Vmjl01k5P3BNHiXtcuC8AEqUm3x6+yizbjy6c5fkKKb+iljAR8efNj1K4DrLMA
         Do6bkRJNwTYq+PG5mLWmvb6uSnUzhedWSMdTUWuj/nwoDfo3UowyTVn7ezAdnU+1IW1k
         HTaOo4y2Jzi9yy8CWomlGmqoNYl4Se7ZVYj8pXkKKtZU8BrYyRcj0fGhEtjLWS7jy3BS
         pOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VrcaK2MkLHXfaL+K6GMnNADLdyI+Pp63vvXW1LBLvKg=;
        b=PdrqKyfpfPVXoosDwabGB8pisUahFhMv3xHFm76Q/fTG6/kMM/tKSFJZXYz4rUaFkW
         fuDNpIfLImad3x3yCdcIbVACyYZaFvHaf37FGZgF4kfm+JBgjW4qOhfV9tW+HrGo/x+3
         TPZlZsJTEXN7SUoyUMcmbc9SF8uuly3sx98m1EkqyUJcZ2AorSJjHRuH+FkJkdg3Hccl
         0LUxyF/sNeS09WAt7pK00Nv7ZZrPkP8nxD4icyqwOGINL70GSIoG4krbq4u97jr3bCy8
         0Q+A8jkZZuEDxB+MCajWopLAJqF5aWkx3iNqTVaFtz3MTTeuRQCgQIdN6va2ZSqxhd5S
         G2Zg==
X-Gm-Message-State: ACgBeo1vHxvz6H2E47ll8TIDIJ/SjOOCxt+E+8vBkTsJpbbYd/DB29vV
        h8wfZWfvyug7f/E3XZBT8MHfBTEPMs3Bt1euhD0=
X-Google-Smtp-Source: AA6agR6Xeswu0oB4hVQW9PgehKj7CWsMlN0L4e6sqgkEkO5wsLH/6VtoDConMONgtkPg2OImcsz4LJ4uRuY4TLBWmvM=
X-Received: by 2002:a05:6214:c22:b0:497:10a8:3067 with SMTP id
 a2-20020a0562140c2200b0049710a83067mr12164981qvd.48.1661803490761; Mon, 29
 Aug 2022 13:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <630d105e.ndcPUQJswrnHbuox%lkp@intel.com>
In-Reply-To: <630d105e.ndcPUQJswrnHbuox%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Aug 2022 23:04:14 +0300
Message-ID: <CAHp75Ve3f=nKbx3ei74r2GL+ugHJt1YMCsZW1g9nYH91PYUbbw@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION b27a3ca08ba7abcf1a8af4dc3dce3e5221d91212
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 29, 2022 at 10:23 PM kernel test robot <lkp@intel.com> wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: b27a3ca08ba7abcf1a8af4dc3dce3e5221d91212  Add linux-next specific files for 20220829
>
> Error/Warning reports:
>
> https://lore.kernel.org/linux-mm/202208190147.RwbMifl8-lkp@intel.com
>
> Error/Warning: (recently discovered and may have been fixed)
>
> drivers/base/regmap/regmap-mmio.c:221:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:224:17: error: implicit declaration of function 'writesw'; did you mean 'writew'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:227:17: error: implicit declaration of function 'writesl'; did you mean 'writel'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writeq'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writesl'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:358:17: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:361:17: error: implicit declaration of function 'readsw'; did you mean 'readw'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:364:17: error: implicit declaration of function 'readsl'; did you mean 'readl'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readq'? [-Werror=implicit-function-declaration]
> drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readsl'? [-Werror=implicit-function-declaration]

Some crazy stuff from Alpha. I believe this was before any of the
current Linux Next patches.

-- 
With Best Regards,
Andy Shevchenko
