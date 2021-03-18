Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449733407BB
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 15:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCROXC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhCROWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 10:22:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0168C06174A;
        Thu, 18 Mar 2021 07:22:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h3so3588007pfr.12;
        Thu, 18 Mar 2021 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SpPndL4fuwSGYT0wdMqweTD3cW2njoeZuj3wFEa3beA=;
        b=beITg+JN/HZTJSz2pfuVXd3uGNd17i+BzLkWn6aYeO6mSFpfBhsI5CnoZwwvdYEmPF
         nkU1USDs0a25FjFGFy8SWZ3wRxNJtUc5tPjsqexAR84vjAE4mmI3Aaehj7N+c/B3j/+i
         THUer6324f/CGccAqKkOpHbvJscmagVqqppabQcXZtFh4qjoNapM8VDdRh/DQETpg1nr
         rfIUMHpah7dHm2HKw7lUrqT/vvxUduinWt3EKdBqSO1EBAWl+YVwY9E3nWktCqOV559Y
         2juQtilA7puyRm0O/VBCwz1Wwb0ZaWNue6OFvCA+YI1RqfH3t4CunaVqrgNW33HAsh3i
         Y7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SpPndL4fuwSGYT0wdMqweTD3cW2njoeZuj3wFEa3beA=;
        b=Ssj8yGjImITD+ec2TzRK60YAnxd1VQsZ/eHUwQEf62y+G0+LfVt3ncsvF087DRa9Bg
         5Zs8y12hus2dMtUc6Ucp4ktUUaq818ScErJfV9hZCJBGdbHBDFA2v703NayXZuFe/tr2
         JXW3AiFJHpWvDd52dCvFlbHWAs6sIpWOSNKBWFaXkns0aTkhvAQZNAsastZaWcGwgKgp
         Mpo0H5zGXrg9EjgRYATeCYdFMBTWSVif0HnpS8TyEpwwsFi5gB2zW3hlwlXYaa1GNO1v
         POYhf4/ZKhTcN/ydkHDya/kZgOUqMt+DxShW8GdMmh/+vuL5fU+RcjLH09KJvzr17AWG
         58Mw==
X-Gm-Message-State: AOAM533F5RmD3M0rEO9agRtDZ3RtUMa6iCsu5cAJKw0dRZlXtuHZ5Owc
        Ps59bOEGR6NYjLFWYzrWs1M=
X-Google-Smtp-Source: ABdhPJyR24ru6fcIXgtjRI2ZQDrCD6tN+QXRQ36xEMy2k7jb42e2y6TNv7qZF7TMMHWMvOaMwVhVjw==
X-Received: by 2002:a62:2b85:0:b029:1ee:e2a2:cbee with SMTP id r127-20020a622b850000b02901eee2a2cbeemr4280269pfr.78.1616077343058;
        Thu, 18 Mar 2021 07:22:23 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i17sm2850601pfq.135.2021.03.18.07.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 07:22:22 -0700 (PDT)
Date:   Thu, 18 Mar 2021 23:22:15 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        david@lechnology.com, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, alexandre.belloni@bootlin.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
        o.rempel@pengutronix.de, Dan Carpenter <dan.carpenter@oracle.com>,
        kernel@pengutronix.de, syednwaris@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@foss.st.com
Subject: Re: [Linux-stm32] [PATCH v9 22/33] counter: Internalize sysfs
 interface code
Message-ID: <YFNiF1JlgiRxEKDB@shinobu>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
 <377a1552e7794ca4d998d840c06ba4a109214863.1615293276.git.vilhelm.gray@gmail.com>
 <b195e59c-470b-8a06-7308-42bd628274bd@foss.st.com>
 <YE3BvAsx4exhWG+C@shinobu>
 <YE3SqJypA1UE86Sr@shinobu>
 <fa974bd9-96bc-3647-a5b7-5d268e459753@foss.st.com>
 <3c3183c4-c9da-709b-dff3-ab5e407e042b@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YAD6cNnDImkM3riC"
Content-Disposition: inline
In-Reply-To: <3c3183c4-c9da-709b-dff3-ab5e407e042b@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--YAD6cNnDImkM3riC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 11:10:29AM +0100, Fabrice Gasnier wrote:
> On 3/18/21 10:21 AM, Fabrice Gasnier wrote:
> > On 3/14/21 10:08 AM, William Breathitt Gray wrote:
> >> On Sun, Mar 14, 2021 at 04:56:44PM +0900, William Breathitt Gray wrote:
> >>> On Fri, Mar 12, 2021 at 04:02:42PM +0100, Fabrice Gasnier wrote:
> >>>> On 3/9/21 2:19 PM, William Breathitt Gray wrote:
> >>>>> +static ssize_t enums_available_show(const u32 *const enums,
> >>>>> +				    const size_t num_enums,
> >>>>> +				    const char *const strs[], char *buf)
> >>>>> +{
> >>>>> +	size_t len =3D 0;
> >>>>> +	size_t index;
> >>>>> +
> >>>>> +	for (index =3D 0; index < num_enums; index++)
> >>>>> +		len +=3D sysfs_emit(buf + len, "%s\n", strs[enums[index]]);
> >>>>> +
> >>>>> +	return len;
> >>>>> +}
> >>>>> +
> >>>>> +static ssize_t strs_available_show(const struct counter_available =
*const avail,
> >>>>> +				   char *buf)
> >>>>> +{
> >>>>> +	size_t len =3D 0;
> >>>>> +	size_t index;
> >>>>> +
> >>>>> +	for (index =3D 0; index < avail->num_items; index++)
> >>>>> +		len +=3D sysfs_emit(buf + len, "%s\n", avail->strs[index]);
> >>>>> +
> >>>>> +	return len;
> >>>>> +}
> >>>>
> >>>> Hi William,
> >>>>
> >>>> I was willing to do some testing on this series, on the stm32 counter
> >>>> drivers, since we released few fixes around them.
> >>>>
> >>>> I tried to apply this series against current testing branch, with few
> >>>> patches applied (so it applies cleanly):
> >>>> - dt-bindings: counter: add interrupt-counter binding
> >>>> - counter: add IRQ or GPIO based counter
> >>>> - counter: stm32-timer-cnt: fix ceiling miss-alignment with reload r=
egister
> >>>> - counter: stm32-timer-cnt: fix ceiling write max value
> >>>>  counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DIS=
ABLED
> >>>>
> >>>>
> >>>> For both the "stm32-lptimer-cnt" and "stm32-timer-cnt" drivers, I ge=
t a
> >>>> warning message and stack dump in "sysfs_emit" when reading the
> >>>> available functions from sysfs.
> >>>> I started to do some testing on v8 of this series last week. I didn't
> >>>> noticed that.
> >>>>
> >>>> For both the "stm32-lptimer-cnt", there are 2 functions currently I =
get
> >>>> 1 stack dump. Only the "increase" function is printed correctly.
> >>>>
> >>>> For the "stm32-timer-cnt", there are 4 functions currently, I get 3
> >>>> stack dumps. Only the "increase" function is printed correctly
> >>>>
> >>>> Sample log for "stm32-timer-cnt:
> >>>>
> >>>> root@stm32mp1:/sys/devices/platform/soc/44000000.timer/44000000.time=
r:counter/counter0#
> >>>> cat count0/function_available
> >>>> [ 4689.195506] ------------[ cut here ]------------
> >>>> [ 4689.198747] WARNING: CPU: 1 PID: 5841 at fs/sysfs/file.c:737
> >>>> sysfs_emit+0x88/0x94
> >>>> [ 4689.206233] invalid sysfs_emit: buf:f4a66208
> >>>> [ 4689.210553] Modules linked in: sha256_generic libsha256 sha256_arm
> >>>> cfg80211 panel_orisetech_otm8009a snd_soc_hdmi_codec
> >>>> snd_soc_stm32_sai_sub stm32_lptimers
> >>>> [ 4689.261444] CPU: 1 PID: 5841 Comm: cat Tainted: G        W
> >>>> 5.12.0-rc1 #534
> >>>> [ 4689.268999] Hardware name: STM32 (Device Tree Support)
> >>>> [ 4689.274166] [<c0310b38>] (unwind_backtrace) from [<c030b4ec>]
> >>>> (show_stack+0x10/0x14)
> >>>> [ 4689.281942] [<c030b4ec>] (show_stack) from [<c0fede70>]
> >>>> (dump_stack+0xc0/0xd4)
> >>>> [ 4689.289199] [<c0fede70>] (dump_stack) from [<c0345624>]
> >>>> (__warn+0xec/0x148)
> >>>> [ 4689.296194] [<c0345624>] (__warn) from [<c0fe9e90>]
> >>>> (warn_slowpath_fmt+0x98/0xbc)
> >>>> [ 4689.303714] [<c0fe9e90>] (warn_slowpath_fmt) from [<c0548ee0>]
> >>>> (sysfs_emit+0x88/0x94)
> >>>> [ 4689.311586] [<c0548ee0>] (sysfs_emit) from [<bf115de8>]
> >>>> (counter_comp_available_show+0x11c/0x1a4 [counter])
> >>>> [ 4689.321382] [<bf115de8>] (counter_comp_available_show [counter]) =
=66rom
> >>>> [<c0a21b70>] (dev_attr_show+0x18/0x48)
> >>>> [ 4689.331263] [<c0a21b70>] (dev_attr_show) from [<c0549014>]
> >>>> (sysfs_kf_seq_show+0x88/0xf0)
> >>>> [ 4689.339394] [<c0549014>] (sysfs_kf_seq_show) from [<c04da6e8>]
> >>>> (seq_read_iter+0x1a4/0x554)
> >>>> [ 4689.347703] [<c04da6e8>] (seq_read_iter) from [<c04af6f0>]
> >>>> (vfs_read+0x1ac/0x2c4)
> >>>> [ 4689.355224] [<c04af6f0>] (vfs_read) from [<c04afc20>]
> >>>> (ksys_read+0x64/0xdc)
> >>>> [ 4689.362219] [<c04afc20>] (ksys_read) from [<c03000c0>]
> >>>> (ret_fast_syscall+0x0/0x58)
> >>>> [ 4689.369827] Exception stack(0xc7261fa8 to 0xc7261ff0)
> >>>> [ 4689.374906] 1fa0:                   00000000 00020000 00000003
> >>>> b6f35000 00020000 00000000
> >>>> [ 4689.383126] 1fc0: 00000000 00020000 b6f56ce0 00000003 00000003
> >>>> 00000000 00020000 00000000
> >>>> [ 4689.391344] 1fe0: 00000003 be8239a8 410bff27 4104c066
> >>>> ...
> >>>> 2 more stack dumps follow
> >>>> ...
> >>>> [ 4689.810479] ---[ end trace 59ed79949efe984c ]---
> >>>> increase
> >>>>
> >>>> I get similar backtrace with other _available attributes:
> >>>> $ cat signal0_action_available
> >>>> $ cat signal1_action_available
> >>>>
> >>>> Do you think I'm doing something wrong ?
> >>>>
> >>>> I tested then "quadrature x4" on the timer driver... It seems all fi=
ne.
> >>>>
> >>>> Best regards
> >>>> Fabrice
> >>>>
> >>>>> +
> >>>>> +static ssize_t counter_comp_available_show(struct device *dev,
> >>>>> +					   struct device_attribute *attr,
> >>>>> +					   char *buf)
> >>>>> +{
> >>>>> +	const struct counter_attribute *const a =3D to_counter_attribute(=
attr);
> >>>>> +	const struct counter_count *const count =3D a->parent;
> >>>>> +	const struct counter_synapse *const synapse =3D a->comp.priv;
> >>>>> +	const struct counter_available *const avail =3D a->comp.priv;
> >>>>> +
> >>>>> +	switch (a->comp.type) {
> >>>>> +	case COUNTER_COMP_FUNCTION:
> >>>>> +		return enums_available_show(count->functions_list,
> >>>>> +					    count->num_functions,
> >>>>> +					    counter_function_str, buf);
> >>>>> +	case COUNTER_COMP_SYNAPSE_ACTION:
> >>>>> +		return enums_available_show(synapse->actions_list,
> >>>>> +					    synapse->num_actions,
> >>>>> +					    counter_synapse_action_str, buf);
> >>>>> +	case COUNTER_COMP_ENUM:
> >>>>> +		return strs_available_show(avail, buf);
> >>>>> +	case COUNTER_COMP_COUNT_MODE:
> >>>>> +		return enums_available_show(avail->enums, avail->num_items,
> >>>>> +					    counter_count_mode_str, buf);
> >>>>> +	default:
> >>>>> +		return -EINVAL;
> >>>>> +	}
> >>>>> +}
> >>>
> >>> Hi Fabrice,
> >>>
> >>> I can confirm that I'm hitting this regression as well with the
> >>> 104-quad-8 driver. The warning seems to be caused by the
> >>> offset_in_page(buf) check in sysfs_emit(). It looks like the first lo=
op
> >>> in enums_available_show() calls sysfs_emit() correctly, but subsequent
> >>> loops have an invalid buf offset.
> >>>
> >>> The enums_available_show() callback is rather simple: call sysfs_emit=
()
> >>> for each enum string and increment buf by the length written each tim=
e.
> >>> I haven't modified this function since v8, so I am somewhat confused
> >>> about why the buf offset would be invalid here now. I wonder if there
> >>> has been a change somewhere else in the kernel that is causing
> >>> sysfs_emit() to now return an incorrect length.
> >>>
> >>> William Breathitt Gray
> >>
> >> Fabrice,
> >>
> >> Would you be able to check the values of buf and len before they enter
> >> sysfs_emit()? I think redefining the enums_available_show() function
> >> like this should suffice:
> >>
> >> static ssize_t enums_available_show(const u32 *const enums,
> >>                                     const size_t num_enums,
> >>                                     const char *const strs[], char *bu=
f)
> >> {
> >>         size_t len =3D 0;
> >>         size_t index;
> >>
> >>         for (index =3D 0; index < num_enums; index++){
> >>                 pr_info("buf: %p\tbuf+len: %p\tlen: %zu\n", buf, buf +=
 len, len);
> >>                 len +=3D sysfs_emit(buf + len, "%s\n", strs[enums[inde=
x]]);
> >>         }
> >>
> >>         return len;
> >> }
> >>
> >> I want to see whether the issue is due to the sysfs_emit() return value
> >> or the value of buf.
> >=20
> > Hi William,
> >=20
> > Sorry for the delay,
> >=20
> > I'm getting strange results on buf+len. Here's the result I'm getting
> > with same test as above:
> >=20
> > [  170.190995] buf: 5daf3333    buf+len: 5daf3333       len: 0
> > [  170.194383] buf: 5daf3333    buf+len: 22c37039       len: 9
> > [  170.199268] ------------[ cut here ]------------
> > ...
> > [  170.404810] buf: 5daf3333    buf+len: 22c37039       len: 9
> > [  170.409663] ------------[ cut here ]------------
> > ...
> > [  170.615265] buf: 5daf3333    buf+len: 22c37039       len: 9
> > [  170.620117] ------------[ cut here ]------------
> > ...
> > increase
>=20
> William,
>=20
> I did the same, with %px instead of %p, and i'm getting:
>=20
> [  124.001041] buf: c60fb000    buf+len: c60fb000       len: 0
> [  124.009442] buf: c60fb000    buf+len: c60fb009       len: 9
> [  124.019118] ------------[ cut here ]------------
> ...
> So, I believe this is caused by the offset_in_page(buf) check, in
> sysfs_emit().
>=20
> I also double checked it on the v8 patchset, and I already had the same
> behavior. So I likely didn't checked the available attrs earlier. Sorry
> for this confusion.
>=20
> Best Regards,
> Fabrice

Ah, I forgot %p doesn't show the true address. Okay so it looks like we
can't use sysfs_emit() with an offset. I'll change these sysfs_emit()
lines to use scnprintf() instead and that should prevent the warnings
=66rom triggering.

Thanks,

William Breathitt Gray

--YAD6cNnDImkM3riC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBTYg0ACgkQhvpINdm7
VJJM8xAAuz6XycB6mew7tFuX9DMfASh0sZZ8fZX+aYamxAfEz+x8T7uOCdSbeHZ8
z1rRMLCRWzmRa5yiqWpmjJXvzMTDKUzEF/vBlGfHEZfMpGD9EKvZFfDBw+WJFoSl
yBROKzyc1dAvbKnDnWrzblHTxfxN2GiFhtN6qfs7poIznjLjUVzmP5EUKXCgVAW9
WLuyc49zwTgBHppTvtJfghnJhy6X5Vvi1zUz2dHwrF1gochaiYSP9fVUQXiotC5i
T0uyD6Sdrs2fYxQ5KEF0YGUHRg5Fm14hknf5tQS9nlcDMuXnAWsan9tn64lRgjZh
0zPHSv03CI8cJ2jedIXr/GM0Erm1zF8i9aZf4r0YB8yzXP2b1hjCKdt3vvMA6hww
eNNHYr5UkBnGCQxfD5VUml/xcTFHVaMFWaq9V20kWCXqiqnXVHALtahU7ZFLuc6w
ClKGmhIgdWns2wUVw81AjT0b+hv1Qoel2+3waTjzHWyAYJ7jHjUCthCbzZoNWuNL
ba3lPAV2MT1qDclm2RNsVvrG9RADFvoJbG+i7HsnDJcSR7jKEPCv/KMfozamrlj/
9529IfCF+Svsxb5yy72GBFciBVv7nZhjRVcDZdIk3Aor5R3BITnjUC2rQODL5Wx6
k8VUQF/B+/BzbNYbJxr1gxUj4yGwR2J50H4dRKeZPrAIrfLAIjY=
=5l0o
-----END PGP SIGNATURE-----

--YAD6cNnDImkM3riC--
