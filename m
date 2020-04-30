Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F051BF903
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 15:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgD3NON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgD3NON (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 09:14:13 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49003C035494;
        Thu, 30 Apr 2020 06:14:13 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id w18so2933659qvs.3;
        Thu, 30 Apr 2020 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pDdNvxiaHux68POpVOp2tfQ9DF2c5DQah7EUfVYCx48=;
        b=E0h/T0SHPd8VBNoJF8aBlM6G0p9wcDVCz80Sn50j4stfFRESoyn4/8aBAm4wiI/h8W
         cJtfqFoOP2uoHiEQxrbtiMAFoG/MUAy9qA/bYv3H1EkAlpTHTpk3UrqjXBfHMgPpcf+Q
         8STgihdHuZypZe+LYN4XMOEboF22wQmoGSjWzV8CMvj+ge85/0l5ulwfpuzN8UOtWsv9
         4WRr5Oi2iYznpzTsenrbuimRf6DvCq4didSJnpikbDkztan2cqA6Tvq70gWjjTotiYjL
         E8ffjaCXtOq2HlX50pDlgqg8rRQRrRSDvi5Ta9g7J07q2biMniAibTY9hiWP7SvwuEfH
         PM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDdNvxiaHux68POpVOp2tfQ9DF2c5DQah7EUfVYCx48=;
        b=Fc/+APLch3s04jB1uh97dCQhxDsB8/G0NDLtAzS8dVO+rRe8mfdhI+os9YUVcwiSxI
         81xu/2H7HSAnm5S0odrCAIuO6WXXwpXys+L28qE1lDhotY6LycXZ2I4fI6F7dG45ymEV
         Y8g+0BW1gOyyBHEXJ7PS4m7wWFqulsQ5bWxi7kbO6TltmShxYrSFqqyf7Vv5glQwDwen
         WZ+vF8Z3yGPO889roNsgC0Bycht9H1mvZwIrdtORmLlK7rKvYUNBZ97iH2+wcXTrmmGS
         9RzAcILoiS2OT9hyfLqn23idNRW+KBu9mU+c7ftxwQEUO4mjEG/TLZeW7WKeYrRl3wzO
         dVHw==
X-Gm-Message-State: AGi0PubjxFbodzCO3+7zKGoLw5BXycE/3aIY0v155cqfeG/WNKYyOYms
        e92x97l3NB4LpXPEe0MVADs=
X-Google-Smtp-Source: APiQypLZgkNpKfCBuKLEZD2YLW/rJjGZln92wUBimE1AWUJGk335FmNHsaMpWGh7zLEChyYWIrQx2Q==
X-Received: by 2002:ad4:5604:: with SMTP id ca4mr3001987qvb.6.1588252451956;
        Thu, 30 Apr 2020 06:14:11 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u5sm1807186qkm.116.2020.04.30.06.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:14:10 -0700 (PDT)
Date:   Thu, 30 Apr 2020 09:13:54 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     jic23@kernel.org, kbuild-all@lists.01.org,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        felipe.balbi@linux.intel.com, fabien.lahoudere@collabora.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] counter: Internalize sysfs interface code
Message-ID: <20200430131354.GA3526@icarus>
References: <d84f0bb3258d1664e90da64d75f787829c50a9bd.1588176662.git.vilhelm.gray@gmail.com>
 <202004301522.tS6NKxKy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <202004301522.tS6NKxKy%lkp@intel.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 03:41:26PM +0800, kbuild test robot wrote:
> Hi William,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on stm32/stm32-next]
> [cannot apply to linus/master linux/master v5.7-rc3 next-20200429]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>=20
> url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/I=
ntroduce-the-Counter-character-device-interface/20200430-051734
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git=
 stm32-next
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers/counter/stm32-lptimer-cnt.c:387:2: error: initializer element =
is not constant
>      stm32_lptim_l2c_actions_map[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE],
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/counter/stm32-lptimer-cnt.c:387:2: note: (near initialization =
for 'stm32_lptim_cnt_synapse_actions[0]')
>    drivers/counter/stm32-lptimer-cnt.c:388:2: error: initializer element =
is not constant
>      stm32_lptim_l2c_actions_map[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE],
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/counter/stm32-lptimer-cnt.c:388:2: note: (near initialization =
for 'stm32_lptim_cnt_synapse_actions[1]')
>    drivers/counter/stm32-lptimer-cnt.c:389:2: error: initializer element =
is not constant
>      stm32_lptim_l2c_actions_map[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES],
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/counter/stm32-lptimer-cnt.c:389:2: note: (near initialization =
for 'stm32_lptim_cnt_synapse_actions[2]')
>    drivers/counter/stm32-lptimer-cnt.c:390:2: error: initializer element =
is not constant
>      stm32_lptim_l2c_actions_map[STM32_LPTIM_SYNAPSE_ACTION_NONE],
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/counter/stm32-lptimer-cnt.c:390:2: note: (near initialization =
for 'stm32_lptim_cnt_synapse_actions[3]')
>=20
> vim +387 drivers/counter/stm32-lptimer-cnt.c
>=20
>    385=09
>    386	static const enum counter_synapse_action stm32_lptim_cnt_synapse_a=
ctions[] =3D {
>  > 387		stm32_lptim_l2c_actions_map[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDG=
E],
>    388		stm32_lptim_l2c_actions_map[STM32_LPTIM_SYNAPSE_ACTION_FALLING_ED=
GE],
>    389		stm32_lptim_l2c_actions_map[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES=
],
>    390		stm32_lptim_l2c_actions_map[STM32_LPTIM_SYNAPSE_ACTION_NONE],
>    391	};
>    392=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

This array must be initialized with constants. I'll fix this up in v2.

Thanks,

William Breathitt Gray

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6qzwYACgkQhvpINdm7
VJLk/Q//clynsmUq9lcU/8cY8gN9E4wlFY1nGI4H1LZM2GC9Pk6s7CMQjyiTY1Lf
VKUk7T/x2brPTsTR/ctE4Z1vCIBrZ7HzKE1qPBxm2P+CPSMJwbqYfPwhUwYO2GNH
HyAhx8VpxyHGTFJf/IMPFEPY6esJj8nEuj0DrTS8IE0/LqvMzDfaltTWW3eBc1Zl
0734KK8lUwe+4COZvsFkytii3yVVOHNfSQI6b5q1wdRqbLpRA3xQl7STYWsXv4s/
Ed0unHGG+bZPy9ITjTw7FcReGgZUrGZwe+TjFBpAad3Bva0GtW36+cle0m6Bcy6G
omgTRDfQXZkvYlN90CsLGnVhKUEMErsXzQ92HydrQQn6TcgaD4Al2+lKZLvfV5qV
XI9yEiCMyZOxkhOtxl0hAKO7oicM5JFq173nW0dcer0TGOkgCgWNUwb1OPOqYO7X
nh/er1AQRvh6N9MDH8Ypo48Is7z9rYYsYnwzSQ9K6Slyp241y0hJkJ0nhX4xl2Vv
Rn7EzJMvz2d5zLCCyQo8esXNu98Ws4KxF66rgL+0ErMLOS1DOEyAOr5hPHow2u5H
CCcTyCrCMgb46iJ34aHNqovWuLcnwtGYuTul1wuHORCeMCpUeyjDjQzC8MKIesH2
8/LY7e9xG+o/oFl1UNkwi5X1IVekUrCOm6/CAPswRV/tNxnxrmM=
=/poB
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
