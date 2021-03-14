Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B588033A372
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 08:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhCNH5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 03:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNH4w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Mar 2021 03:56:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA78C061574;
        Sat, 13 Mar 2021 23:56:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so12769694pjq.5;
        Sat, 13 Mar 2021 23:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XK4GuS1HBbvcGXfkuGZl41P++yAx0Fa1/MWmvDUyojA=;
        b=NbmG3cezeno0Cj73SqgkwkLpSVonacbwXwwzZ3U3ZK8atPPw9OzEDPwnsiJRze3/UR
         TNxDfuPe/hJny5SxvCFRD8A+JzAbwPAUD8zyvMx5CvA4ytvQ5cC6zI5VqKWB4aRjkTrt
         kStQbSgbcJnvBTPHWkdf8eyGwqErbIr6yWrpqi19XSeHBT0WjKHoI6EX/JV6piM42H8g
         M1FieYCJvG04PtsZTKx38Z1jXcS5Vpf9JtoviHY2dheEbVDAhZZrgsYK62tlDgF1QyFv
         5dbxdIME7vxqkOI6Mb+ckHRoU67oQC8/DgA6JUM8z1REmFVrk3B8lIt5RgVEPxVlkp8n
         MCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XK4GuS1HBbvcGXfkuGZl41P++yAx0Fa1/MWmvDUyojA=;
        b=JFcBnV9ZsWDbmAVpKxlV/YarPTj0eROO5FUALdSxPIkMSMDUJCOxoK6lSGS/LHPCZj
         wbU1Zel3aBHGOFKF+0CHte8xQY6i9D7RtqGCqVkBBfS+d31PCSLpiqQjMtK1tPDloV8K
         UB67weR1U1G3qB3GULwK5vozCCxucPJBr8f+WSojNM9Omqq3gJ2PxDY00RSgf9QHyZuB
         i3UfK/gzkuMwj4cQh6UZjoWNTpzcNax+d4LKBCRC5XKqOttMsuf/T66mm60SiUlvqUII
         vJHtcaaZFzp4ALVAExyMfX+ks5FfrUrsPiEUQ+Lksop1/ON3XC0lELuX9n/AWCn8XfuA
         y9Iw==
X-Gm-Message-State: AOAM530ID3TPVqE2BnnnwoQ04Fm1gm24FTSu/v7kyG5LhF/BRwXgSyvp
        yRp63TSJA59nC3cdASDe87U=
X-Google-Smtp-Source: ABdhPJwUzWhyeVM9IJAKrjgT5e+ZWWs+wjxMpF8QKyj8zmx5Wrh6ocRV0veE0lwAMcRe/4aeuFJ7mw==
X-Received: by 2002:a17:90a:a108:: with SMTP id s8mr6992367pjp.199.1615708611984;
        Sat, 13 Mar 2021 23:56:51 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id b17sm9929341pfp.136.2021.03.13.23.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 23:56:51 -0800 (PST)
Date:   Sun, 14 Mar 2021 16:56:44 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        david@lechnology.com, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, alexandre.belloni@bootlin.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
        o.rempel@pengutronix.de, Dan Carpenter <dan.carpenter@oracle.com>,
        kernel@pengutronix.de, fabrice.gasnier@st.com,
        syednwaris@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com
Subject: Re: [Linux-stm32] [PATCH v9 22/33] counter: Internalize sysfs
 interface code
Message-ID: <YE3BvAsx4exhWG+C@shinobu>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
 <377a1552e7794ca4d998d840c06ba4a109214863.1615293276.git.vilhelm.gray@gmail.com>
 <b195e59c-470b-8a06-7308-42bd628274bd@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OX+k5tirlBCrf7ng"
Content-Disposition: inline
In-Reply-To: <b195e59c-470b-8a06-7308-42bd628274bd@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--OX+k5tirlBCrf7ng
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 04:02:42PM +0100, Fabrice Gasnier wrote:
> On 3/9/21 2:19 PM, William Breathitt Gray wrote:
> > +static ssize_t enums_available_show(const u32 *const enums,
> > +				    const size_t num_enums,
> > +				    const char *const strs[], char *buf)
> > +{
> > +	size_t len =3D 0;
> > +	size_t index;
> > +
> > +	for (index =3D 0; index < num_enums; index++)
> > +		len +=3D sysfs_emit(buf + len, "%s\n", strs[enums[index]]);
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t strs_available_show(const struct counter_available *con=
st avail,
> > +				   char *buf)
> > +{
> > +	size_t len =3D 0;
> > +	size_t index;
> > +
> > +	for (index =3D 0; index < avail->num_items; index++)
> > +		len +=3D sysfs_emit(buf + len, "%s\n", avail->strs[index]);
> > +
> > +	return len;
> > +}
>=20
> Hi William,
>=20
> I was willing to do some testing on this series, on the stm32 counter
> drivers, since we released few fixes around them.
>=20
> I tried to apply this series against current testing branch, with few
> patches applied (so it applies cleanly):
> - dt-bindings: counter: add interrupt-counter binding
> - counter: add IRQ or GPIO based counter
> - counter: stm32-timer-cnt: fix ceiling miss-alignment with reload regist=
er
> - counter: stm32-timer-cnt: fix ceiling write max value
>  counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABLED
>=20
>=20
> For both the "stm32-lptimer-cnt" and "stm32-timer-cnt" drivers, I get a
> warning message and stack dump in "sysfs_emit" when reading the
> available functions from sysfs.
> I started to do some testing on v8 of this series last week. I didn't
> noticed that.
>=20
> For both the "stm32-lptimer-cnt", there are 2 functions currently I get
> 1 stack dump. Only the "increase" function is printed correctly.
>=20
> For the "stm32-timer-cnt", there are 4 functions currently, I get 3
> stack dumps. Only the "increase" function is printed correctly
>=20
> Sample log for "stm32-timer-cnt:
>=20
> root@stm32mp1:/sys/devices/platform/soc/44000000.timer/44000000.timer:cou=
nter/counter0#
> cat count0/function_available
> [ 4689.195506] ------------[ cut here ]------------
> [ 4689.198747] WARNING: CPU: 1 PID: 5841 at fs/sysfs/file.c:737
> sysfs_emit+0x88/0x94
> [ 4689.206233] invalid sysfs_emit: buf:f4a66208
> [ 4689.210553] Modules linked in: sha256_generic libsha256 sha256_arm
> cfg80211 panel_orisetech_otm8009a snd_soc_hdmi_codec
> snd_soc_stm32_sai_sub stm32_lptimers
> [ 4689.261444] CPU: 1 PID: 5841 Comm: cat Tainted: G        W
> 5.12.0-rc1 #534
> [ 4689.268999] Hardware name: STM32 (Device Tree Support)
> [ 4689.274166] [<c0310b38>] (unwind_backtrace) from [<c030b4ec>]
> (show_stack+0x10/0x14)
> [ 4689.281942] [<c030b4ec>] (show_stack) from [<c0fede70>]
> (dump_stack+0xc0/0xd4)
> [ 4689.289199] [<c0fede70>] (dump_stack) from [<c0345624>]
> (__warn+0xec/0x148)
> [ 4689.296194] [<c0345624>] (__warn) from [<c0fe9e90>]
> (warn_slowpath_fmt+0x98/0xbc)
> [ 4689.303714] [<c0fe9e90>] (warn_slowpath_fmt) from [<c0548ee0>]
> (sysfs_emit+0x88/0x94)
> [ 4689.311586] [<c0548ee0>] (sysfs_emit) from [<bf115de8>]
> (counter_comp_available_show+0x11c/0x1a4 [counter])
> [ 4689.321382] [<bf115de8>] (counter_comp_available_show [counter]) from
> [<c0a21b70>] (dev_attr_show+0x18/0x48)
> [ 4689.331263] [<c0a21b70>] (dev_attr_show) from [<c0549014>]
> (sysfs_kf_seq_show+0x88/0xf0)
> [ 4689.339394] [<c0549014>] (sysfs_kf_seq_show) from [<c04da6e8>]
> (seq_read_iter+0x1a4/0x554)
> [ 4689.347703] [<c04da6e8>] (seq_read_iter) from [<c04af6f0>]
> (vfs_read+0x1ac/0x2c4)
> [ 4689.355224] [<c04af6f0>] (vfs_read) from [<c04afc20>]
> (ksys_read+0x64/0xdc)
> [ 4689.362219] [<c04afc20>] (ksys_read) from [<c03000c0>]
> (ret_fast_syscall+0x0/0x58)
> [ 4689.369827] Exception stack(0xc7261fa8 to 0xc7261ff0)
> [ 4689.374906] 1fa0:                   00000000 00020000 00000003
> b6f35000 00020000 00000000
> [ 4689.383126] 1fc0: 00000000 00020000 b6f56ce0 00000003 00000003
> 00000000 00020000 00000000
> [ 4689.391344] 1fe0: 00000003 be8239a8 410bff27 4104c066
> ...
> 2 more stack dumps follow
> ...
> [ 4689.810479] ---[ end trace 59ed79949efe984c ]---
> increase
>=20
> I get similar backtrace with other _available attributes:
> $ cat signal0_action_available
> $ cat signal1_action_available
>=20
> Do you think I'm doing something wrong ?
>=20
> I tested then "quadrature x4" on the timer driver... It seems all fine.
>=20
> Best regards
> Fabrice
>=20
> > +
> > +static ssize_t counter_comp_available_show(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	const struct counter_attribute *const a =3D to_counter_attribute(attr=
);
> > +	const struct counter_count *const count =3D a->parent;
> > +	const struct counter_synapse *const synapse =3D a->comp.priv;
> > +	const struct counter_available *const avail =3D a->comp.priv;
> > +
> > +	switch (a->comp.type) {
> > +	case COUNTER_COMP_FUNCTION:
> > +		return enums_available_show(count->functions_list,
> > +					    count->num_functions,
> > +					    counter_function_str, buf);
> > +	case COUNTER_COMP_SYNAPSE_ACTION:
> > +		return enums_available_show(synapse->actions_list,
> > +					    synapse->num_actions,
> > +					    counter_synapse_action_str, buf);
> > +	case COUNTER_COMP_ENUM:
> > +		return strs_available_show(avail, buf);
> > +	case COUNTER_COMP_COUNT_MODE:
> > +		return enums_available_show(avail->enums, avail->num_items,
> > +					    counter_count_mode_str, buf);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}

Hi Fabrice,

I can confirm that I'm hitting this regression as well with the
104-quad-8 driver. The warning seems to be caused by the
offset_in_page(buf) check in sysfs_emit(). It looks like the first loop
in enums_available_show() calls sysfs_emit() correctly, but subsequent
loops have an invalid buf offset.

The enums_available_show() callback is rather simple: call sysfs_emit()
for each enum string and increment buf by the length written each time.
I haven't modified this function since v8, so I am somewhat confused
about why the buf offset would be invalid here now. I wonder if there
has been a change somewhere else in the kernel that is causing
sysfs_emit() to now return an incorrect length.

William Breathitt Gray

--OX+k5tirlBCrf7ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBNwZwACgkQhvpINdm7
VJJ55Q//SClbiv5JgGdODpISijHCc9CIVrAHGlf42xDTNs2jX1lpJsUDg6YBC+VJ
LEXB3kq5q4IuqwZm83PNlUm0KeSmzd6FlvBiahUVxF/6r+sb18d4UoN3RpCdEeYe
/9Ck1Okjk7MBQEg289zNc78gT+juobAS0G9gzHBn9xTKWvhUQLe89G8or2u/mey1
Udz8InSR3WhNFEKosZbEqnJU1mTJHP39XQX3nXfVPi/LsOQGBWPGtvcylITg/eMd
fDLa+j0ShR6fZ3VTBSCLKfqnzmkNSI9qNDhSRQhsS6c9jWVj7z4JWUvQknOVoeGC
55ygLX9OlwrDauS0ULxTLxcv4Jjg2kWvnoBS45+UXlwmr/0WkDls3wpEnZaduQdf
+BeL5LQxBat4W24XQVbd+B9mRWg4Yt6MerrlzWe2iUt+cCzUsXhU4DZ3pLCH8bBU
+MGcxa4vfcR63ip8JfPwhoPp88uf1Wihv3YMkLgnfvkhszw/an3t6KTPmfZQBlva
uOD9+G6U9W+MXVjQTYWL2/lmdh7C0TdArjoqx0UcPvqrxvQYIlvCnAH3RRk1zzUP
MGstKkUhQKZfeRuOQ6kniN2t1J+6ExHEpyfwpDyvmdYAk80y+9xoHgSUiUVJw+kK
2+ppGOyFCqUz4e+V6DNVTe9UGBdUPv5tlWetaWrVsChflOZf1q8=
=SRv8
-----END PGP SIGNATURE-----

--OX+k5tirlBCrf7ng--
