Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8B33A3B8
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 10:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhCNJJH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 05:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhCNJJF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Mar 2021 05:09:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059EBC061574;
        Sun, 14 Mar 2021 01:09:04 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x21so3440082pfa.3;
        Sun, 14 Mar 2021 01:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tJrE5yB0s4MYuzTDxyIGPDzIPpwerkBrEWrfe5LUuh4=;
        b=ZiFf71vkGBezYsRPGDA4SNIhyJJ3fCxxhr48uBDiADsdJzUNqHGbZM/Ars500CoD/C
         U9V2gbxkBvym87OvrSjgpiC+STwtx5neNLII5Amq+ol1192XlqLfzPtS4kVgOaHmXPF7
         SyluA3ztVHFoTiDAnM5Ly+s0P0jyi+EypmSPDhdNpL2vUqtn9ALvcvb6KuC5f22oLVQZ
         UcUiXgNJQBViTzk1g42zPk2RvKNynLC4iiSWwFt1lOadsS4Wd+n+7Wr//560Kevl6u/X
         CQDB0ks09jrP7tMDDcrJD1ztDwh7JZjwJpTkMJ0mSXkgdM9GJkC4cC0Ww8K5Ov01sCoD
         gMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJrE5yB0s4MYuzTDxyIGPDzIPpwerkBrEWrfe5LUuh4=;
        b=tvOnkNwX2EaqzxmEZSc33rx16BBA/QQ9SQu3LCeY3XZ2GiLfoGcAf5plGYRHArMtVH
         3l9nqaA0qGQ2QTaXOgU6qO0OBSeZDOtMSTNQHX1H6XdRBenoVRhm53xJiAXDdnJQUuNM
         oMXnjF7dx8tniI5ecwEjxpOmhjCocPGfA9gbcBYw2VXij5XU7xEqe0K5tJMKYdLLukFz
         kz3Hs/VaCkX3kLKoKy7yOdlo4oYgGy6TLIOs1DycWLMPg01FaEUJcew4T8rFBdXXKZLJ
         HaguZ8uaKkA30pm/St67AAJMGCgTG3gNzb3HJ3gDvUbjgOOcz0zU4vkHHGsyFRUx/Zgp
         oKAQ==
X-Gm-Message-State: AOAM532ia4HQpy6MGz/Wd9MGu/vi1+u3fqJ/BLXwd0D1vATkwuU9mUgH
        5AYO8CEncvq1ew0jG1oY4S0=
X-Google-Smtp-Source: ABdhPJyJ9RuW9uTpPw9TttzqomrqpE8AqLzOzb5l5qEfxF4ZFzs0Mn05ItcnoILUrl1g86roCc6rjg==
X-Received: by 2002:a62:e404:0:b029:1f1:5cea:afbd with SMTP id r4-20020a62e4040000b02901f15ceaafbdmr5910905pfh.5.1615712944192;
        Sun, 14 Mar 2021 01:09:04 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id h186sm10242385pgc.38.2021.03.14.01.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 01:09:03 -0800 (PST)
Date:   Sun, 14 Mar 2021 18:08:56 +0900
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
Message-ID: <YE3SqJypA1UE86Sr@shinobu>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
 <377a1552e7794ca4d998d840c06ba4a109214863.1615293276.git.vilhelm.gray@gmail.com>
 <b195e59c-470b-8a06-7308-42bd628274bd@foss.st.com>
 <YE3BvAsx4exhWG+C@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EpN61qC1eJVFbM4k"
Content-Disposition: inline
In-Reply-To: <YE3BvAsx4exhWG+C@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--EpN61qC1eJVFbM4k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2021 at 04:56:44PM +0900, William Breathitt Gray wrote:
> On Fri, Mar 12, 2021 at 04:02:42PM +0100, Fabrice Gasnier wrote:
> > On 3/9/21 2:19 PM, William Breathitt Gray wrote:
> > > +static ssize_t enums_available_show(const u32 *const enums,
> > > +				    const size_t num_enums,
> > > +				    const char *const strs[], char *buf)
> > > +{
> > > +	size_t len =3D 0;
> > > +	size_t index;
> > > +
> > > +	for (index =3D 0; index < num_enums; index++)
> > > +		len +=3D sysfs_emit(buf + len, "%s\n", strs[enums[index]]);
> > > +
> > > +	return len;
> > > +}
> > > +
> > > +static ssize_t strs_available_show(const struct counter_available *c=
onst avail,
> > > +				   char *buf)
> > > +{
> > > +	size_t len =3D 0;
> > > +	size_t index;
> > > +
> > > +	for (index =3D 0; index < avail->num_items; index++)
> > > +		len +=3D sysfs_emit(buf + len, "%s\n", avail->strs[index]);
> > > +
> > > +	return len;
> > > +}
> >=20
> > Hi William,
> >=20
> > I was willing to do some testing on this series, on the stm32 counter
> > drivers, since we released few fixes around them.
> >=20
> > I tried to apply this series against current testing branch, with few
> > patches applied (so it applies cleanly):
> > - dt-bindings: counter: add interrupt-counter binding
> > - counter: add IRQ or GPIO based counter
> > - counter: stm32-timer-cnt: fix ceiling miss-alignment with reload regi=
ster
> > - counter: stm32-timer-cnt: fix ceiling write max value
> >  counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABL=
ED
> >=20
> >=20
> > For both the "stm32-lptimer-cnt" and "stm32-timer-cnt" drivers, I get a
> > warning message and stack dump in "sysfs_emit" when reading the
> > available functions from sysfs.
> > I started to do some testing on v8 of this series last week. I didn't
> > noticed that.
> >=20
> > For both the "stm32-lptimer-cnt", there are 2 functions currently I get
> > 1 stack dump. Only the "increase" function is printed correctly.
> >=20
> > For the "stm32-timer-cnt", there are 4 functions currently, I get 3
> > stack dumps. Only the "increase" function is printed correctly
> >=20
> > Sample log for "stm32-timer-cnt:
> >=20
> > root@stm32mp1:/sys/devices/platform/soc/44000000.timer/44000000.timer:c=
ounter/counter0#
> > cat count0/function_available
> > [ 4689.195506] ------------[ cut here ]------------
> > [ 4689.198747] WARNING: CPU: 1 PID: 5841 at fs/sysfs/file.c:737
> > sysfs_emit+0x88/0x94
> > [ 4689.206233] invalid sysfs_emit: buf:f4a66208
> > [ 4689.210553] Modules linked in: sha256_generic libsha256 sha256_arm
> > cfg80211 panel_orisetech_otm8009a snd_soc_hdmi_codec
> > snd_soc_stm32_sai_sub stm32_lptimers
> > [ 4689.261444] CPU: 1 PID: 5841 Comm: cat Tainted: G        W
> > 5.12.0-rc1 #534
> > [ 4689.268999] Hardware name: STM32 (Device Tree Support)
> > [ 4689.274166] [<c0310b38>] (unwind_backtrace) from [<c030b4ec>]
> > (show_stack+0x10/0x14)
> > [ 4689.281942] [<c030b4ec>] (show_stack) from [<c0fede70>]
> > (dump_stack+0xc0/0xd4)
> > [ 4689.289199] [<c0fede70>] (dump_stack) from [<c0345624>]
> > (__warn+0xec/0x148)
> > [ 4689.296194] [<c0345624>] (__warn) from [<c0fe9e90>]
> > (warn_slowpath_fmt+0x98/0xbc)
> > [ 4689.303714] [<c0fe9e90>] (warn_slowpath_fmt) from [<c0548ee0>]
> > (sysfs_emit+0x88/0x94)
> > [ 4689.311586] [<c0548ee0>] (sysfs_emit) from [<bf115de8>]
> > (counter_comp_available_show+0x11c/0x1a4 [counter])
> > [ 4689.321382] [<bf115de8>] (counter_comp_available_show [counter]) from
> > [<c0a21b70>] (dev_attr_show+0x18/0x48)
> > [ 4689.331263] [<c0a21b70>] (dev_attr_show) from [<c0549014>]
> > (sysfs_kf_seq_show+0x88/0xf0)
> > [ 4689.339394] [<c0549014>] (sysfs_kf_seq_show) from [<c04da6e8>]
> > (seq_read_iter+0x1a4/0x554)
> > [ 4689.347703] [<c04da6e8>] (seq_read_iter) from [<c04af6f0>]
> > (vfs_read+0x1ac/0x2c4)
> > [ 4689.355224] [<c04af6f0>] (vfs_read) from [<c04afc20>]
> > (ksys_read+0x64/0xdc)
> > [ 4689.362219] [<c04afc20>] (ksys_read) from [<c03000c0>]
> > (ret_fast_syscall+0x0/0x58)
> > [ 4689.369827] Exception stack(0xc7261fa8 to 0xc7261ff0)
> > [ 4689.374906] 1fa0:                   00000000 00020000 00000003
> > b6f35000 00020000 00000000
> > [ 4689.383126] 1fc0: 00000000 00020000 b6f56ce0 00000003 00000003
> > 00000000 00020000 00000000
> > [ 4689.391344] 1fe0: 00000003 be8239a8 410bff27 4104c066
> > ...
> > 2 more stack dumps follow
> > ...
> > [ 4689.810479] ---[ end trace 59ed79949efe984c ]---
> > increase
> >=20
> > I get similar backtrace with other _available attributes:
> > $ cat signal0_action_available
> > $ cat signal1_action_available
> >=20
> > Do you think I'm doing something wrong ?
> >=20
> > I tested then "quadrature x4" on the timer driver... It seems all fine.
> >=20
> > Best regards
> > Fabrice
> >=20
> > > +
> > > +static ssize_t counter_comp_available_show(struct device *dev,
> > > +					   struct device_attribute *attr,
> > > +					   char *buf)
> > > +{
> > > +	const struct counter_attribute *const a =3D to_counter_attribute(at=
tr);
> > > +	const struct counter_count *const count =3D a->parent;
> > > +	const struct counter_synapse *const synapse =3D a->comp.priv;
> > > +	const struct counter_available *const avail =3D a->comp.priv;
> > > +
> > > +	switch (a->comp.type) {
> > > +	case COUNTER_COMP_FUNCTION:
> > > +		return enums_available_show(count->functions_list,
> > > +					    count->num_functions,
> > > +					    counter_function_str, buf);
> > > +	case COUNTER_COMP_SYNAPSE_ACTION:
> > > +		return enums_available_show(synapse->actions_list,
> > > +					    synapse->num_actions,
> > > +					    counter_synapse_action_str, buf);
> > > +	case COUNTER_COMP_ENUM:
> > > +		return strs_available_show(avail, buf);
> > > +	case COUNTER_COMP_COUNT_MODE:
> > > +		return enums_available_show(avail->enums, avail->num_items,
> > > +					    counter_count_mode_str, buf);
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
>=20
> Hi Fabrice,
>=20
> I can confirm that I'm hitting this regression as well with the
> 104-quad-8 driver. The warning seems to be caused by the
> offset_in_page(buf) check in sysfs_emit(). It looks like the first loop
> in enums_available_show() calls sysfs_emit() correctly, but subsequent
> loops have an invalid buf offset.
>=20
> The enums_available_show() callback is rather simple: call sysfs_emit()
> for each enum string and increment buf by the length written each time.
> I haven't modified this function since v8, so I am somewhat confused
> about why the buf offset would be invalid here now. I wonder if there
> has been a change somewhere else in the kernel that is causing
> sysfs_emit() to now return an incorrect length.
>=20
> William Breathitt Gray

Fabrice,

Would you be able to check the values of buf and len before they enter
sysfs_emit()? I think redefining the enums_available_show() function
like this should suffice:

static ssize_t enums_available_show(const u32 *const enums,
                                    const size_t num_enums,
                                    const char *const strs[], char *buf)
{
        size_t len =3D 0;
        size_t index;

        for (index =3D 0; index < num_enums; index++){
                pr_info("buf: %p\tbuf+len: %p\tlen: %zu\n", buf, buf + len,=
 len);
                len +=3D sysfs_emit(buf + len, "%s\n", strs[enums[index]]);
        }

        return len;
}

I want to see whether the issue is due to the sysfs_emit() return value
or the value of buf.

Thank you,

William Breathitt Gray

--EpN61qC1eJVFbM4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBN0p4ACgkQhvpINdm7
VJK9cBAAysjrATgmOPhs5cHd6oWdl+vCffNIupxnwQ3TK49IsHq2wdrCtMduLQWC
nbwPdNhce3+gwbsIZKKz8KTqVYyl+sELO9ee2MDQfJTsFw4XmHjjtGf2IPACCWP3
21QLF3zTaXQK6OmYpbloAZylB5VyDOf0HT5wSWIPQ9e9RbsoVXpSuMC1ovJgfS/R
FPxTYsKfWF/+qFBU0fGIT3fkQJj4i3fucJ59u+vXJaTZjGIYcBxeYiVs0DM8YOMd
ZlKl1S3zG1PCBCM7DhB0juI0NLp6sdIX9AxkfXTT3tiY8xiB6gVOXU+O+uhwFpl2
hvH9ZM10fl4RsbY3zbpTgLHs9dw7ZNe+DMHIqdIo4yAcvAt1mklFy8oANrcwAfGm
JtwV3/sGl9FbO8zbKVbnRpRBP8gIUaSqgjUjALjfHQYkaaksy0tWNqI6E3bnFEia
OczVrtskHunyXzRESCXwYce+2ChC43IJf86+XhLbILZ77WrpGRs0grTfITiLkh28
/ESikmU2orfONIIIENvAJG7ZLc8ACHhyQkR7ctE3rMBeK2DMss/Rm7JLKE9c+j7O
RLZ661oUdskQfUXUlaVQxM1rAxTa1mn1kc9y0ZhMG1U5k2X1miHQYt8oI19Y/W3B
pGbtr2ob0M8sHWPtBvnKAjQLfLdFgXD1VV8R1gs/NY+Bp6JIrrs=
=oQxd
-----END PGP SIGNATURE-----

--EpN61qC1eJVFbM4k--
