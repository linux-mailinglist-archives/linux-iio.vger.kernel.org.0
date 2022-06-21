Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7739A5528B6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 02:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbiFUAsx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 20:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiFUAsw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 20:48:52 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAAA1AD95
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655772529; bh=SO+xpkI2HVa1yoO42L0RLbiITwupvMGwWnzjCykYI9g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=L6tNg0Gti4hlewh/QaSTX8Zgo5prxOm8SGFONP8pJ6Fx+rq/vwP2FHA9qECUM+Fv3Jx1XD27Zjy+QAbHcdbg7whThyJhOS6GyCuPF1m8yCDMyyXT+cYGlAitx9xkJBdgCcmNanTQ2WqEqOj/C5HuxgZepbNWen9EA9eNne2uQ+ddJ7Kiuvulb43NbVL2LFDQoQISbpxMlAKVy3vZz7DPxBG/s0h5pE9SYarac8PbbZ6iijLoDd2iSJVtgmeSgCvfaG4AnR/bMOqBjwkDKyeR9whMAsxjO3dXX3A7wMahy2dF9aJQtS/ediC1+FNMRyXou9nokixSJtjkgT1BXPP8hQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655772529; bh=u2YhoDlUvalJYi9RZvrpBz9c9EztbaxSmoDFMrZ2OTm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=R/KMFnU3rrLD+uM46ImEG1e/Nme500Tg4iY33RmtXy9l+Jg6gUXMPavBMd8E9hKBc+RcK+dE1FWT/IvvWgeOensXRNH8qminst/6Uy8KgNkXSkSQV11HLFVdRQL7/RGJCmrzFP+2yJeQ76VzYJYvuv03Y2maqQ0QlwMaR72gN7akCV8wTi1C+HlQNne18E6CWNh+SUNDWj9ekllhJR+vAfef3qqq+CIQlqHMNQ+aEUablf9CV44i4VrYsBVclALwVFdVHKn8MmM7QhH0R1S9Czfsbc9XfeJDBh43iW0MHgoEHe5C2nuD3WP+2pFrO3RyXwBN8DWTzMsmy9D92fAB/Q==
X-YMail-OSG: 4bYv0w4VM1nyYj8PAGZ_BNlWmhDwomlu408FZRpH0wGPd99DJZrjOq0iUqZmJkI
 d5V432AMlqeQlsM.0ZnKL3pWEDg46EeQO3Sath7GS3yLkonodlczDsUGdPqH9aO3aFhWe10jnIZl
 CETfyN8EHxiEzJr07e42o7T3UeCZ4WsfhwBF5RZj7tUGnJj6pVSpXfgDTKH8hUWyZ_THGc_Cnym8
 2w50QJe_qyrxDBng6VMDC8YRgQO8AmqByLv3Sw.cucAvpbJH_Qwq9hwbwtjkrTGoLsm6_.EM0fx2
 sF1WRrmwVr.21YT9x7EHcFx.d6HjvsOVDJvBowCI02WaENvteJ8yER7kTSRW1devHRn503IQDfBE
 FXOoPblwTSIntXTYzE569CjMbWkF2nPRByKRfwMfqOqAwYwV0p5p8ic_yMcZbMz8wiyaCed06e01
 fIWPwxKnjKH6N9PnVY3ClwSnNPgurY9n4of2YTbvMTDysXFwVoW11oTJZGDAVNgIGppE4.OEYf8e
 hHGfLEvzjRoXPxQgYf8_Z4BpuENVDTMn0YbVh3hLL5Zg70yTEQV_62ONZWetq..y1_Ta.gMami0G
 7yABPIIL48PjMZeKAMiukwTv_1OlU5.Nge7wF6LdMu3mCO6j5bVEW3qOBfpyKpqXzV33wLU6L7.5
 WhrOAoYStrRby98A7NMLFc8KiRleF8LeHt0Vh5gPugAyPDdZT96FdjXTHzZZAVeEQbGgKx5h48QI
 Vi4Z3mN0z4HpFyPKf0WSz259n5.A2xfYOusNW0pHIg4lrLL1LYul5Th.sk397TUNgx5PU63P9QHn
 aQ9d47z1O2UsYma0oDK8WNcJ_DpLvzQaNZ6Ir79BVSMn6JPgaFZu3G2HSvaL.rAl62.49rxUL588
 PsUCgyWYnbCLxy2YtGr6V257g5SfkXeJ.cgeQhtHFZXU.sSQMYc36ce43OD4IWIr6kyRxcdRPu4h
 8oFrtE2EZVZiw6z6WRmTMPtipDSDLJraO4VpvzozyzSr3ZYiwj77MaZsWPaYuBmB0MfksAnTkYER
 Ukg38k_bpT9lpHP_l6HYcBGWaYPxvnTg4Wr7yYHP5Lr.M1LjueD7RE1jSJ22K6_qWKflGvWOiP0K
 KSu_nhc1FkeeoJy3TaNfcUdXZpVzzpn1DX7W19FC5r83_VgLwacAfwsza0JaRgUcojsktiiaU08e
 h2h12AjSCoGb3am0BApumGetfhM0bbm5VFRJvOWL8VLh4PaEIgJevWQsaqSvL35VCAjcS9Svn_Yn
 YqvZdnikaVWbfa8sl8GrxlbmSVGFgEKTeSfmtTlNJhH17huht7Nuncx5vpw5Yhobdiv8oVDl0Ipu
 YNHKgVs0dG2eWlMF5W36aWPwX0GrGu7RCHpvV.lZ4vW1vWJnzP93AUF31OS5QtOEkbJXpuMqfMJG
 RkUmscEWFTRs1Fprcg.ZZ9O1Tpu4ycjOGx5kIfGVLWxo6iqXLwgIwWdnScAFePP.yz47i8QwQzko
 JTvMN6ybKJlBJ6g2zd6V2RIJFPVvN2kehqOX_z7p9DSO0Zqcl4kA16bzlzJaNcz3Cvj_Ttq53G7r
 cvz0u53S5VQw8736EkNeuIVlVKQpTXM4OJY8B_XBPItWLa1OCNqepB_gDkATPqhH_qK3gh.s5Cmq
 DVQZZfUWOkqNBeGI_dCj00C4QmsCvZ4Fq38jRn7XQ_ZUlE2T6ReFD0R9p7vHlUR5mYT2NFcH2LqL
 Zxa4TILhScY8UXCDznjkn4ZH9c1mpajbs_9EYnDjJyvKOqjAeJpG.9QrrRo1YLrMSYcKEyV4bd8Z
 3l4_TYXrLHZdLF_e4ZJAgzdZu19NPg4fAOnhnZOq3ziYyBQP.BR.cVakykzo.sa6_73Mv3GKtWjf
 M.IZg72xHoirEamc4aNFQvtYm1N8VwEwrsEOpa7a_hJHsM.AjcMWO2TG15FkZBKIDTkaf6U3aV9U
 UnF_D1hdrPe_RO9f_QvaFscaX5psYtKpWVsUdcPO4OsADE6acp0pri.fhjlknjRz_oDvcBB6wVE1
 bx62i_._KKGEeeBK6BdVzMEWNWx7vbRD7bTI75Nt9YphnIAnBrQmKu2vYJp.0B7dbUHPL4qSLApD
 zzH4M22j2KFvofkZYpaMkO.0JmHs_fNqHD.FL1Oo2f5fm37ZLSj2bMcioQ9gdZ8iWRxpINug68qC
 SQcUyRvqX4j9t6YxuMFhmszCgnsdIAO680VQElS_povpKNL0.C0SRYMDVhPZs753xhJ__rMjNZx7
 1w.n8S.oVg9nt2FA5E2bneCCiBZRC4oQ_5OODTfu1T.k86uwJk8WhoVzfJdTFWzGLmUnqRZ1mQwC
 eL0M-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jun 2022 00:48:49 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-bp5rh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 187d0c5f58d87972edeee93df2155db0;
          Tue, 21 Jun 2022 00:48:47 +0000 (UTC)
Message-ID: <a348dbb6-8d4a-bcdb-e992-9b11e1c9f23f@rocketmail.com>
Date:   Tue, 21 Jun 2022 02:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/8] iio: magnetometer: yas530: Correct temperature
 handling
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1655509425.git.jahau@rocketmail.com>
 <076e87f66378be8c729723cb9be5bc9151c081ab.1655509425.git.jahau@rocketmail.com>
 <20220618155331.5da93b88@jic23-huawei>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20220618155331.5da93b88@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 18.06.22 16:53, Jonathan Cameron wrote:
>
> On Sat, 18 Jun 2022 02:13:12 +0200
> Jakob Hauser <jahau@rocketmail.com> wrote:
=2E..
>>  /* These variant IDs are known from code dumps */
>>  #define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
>> @@ -314,7 +315,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx,=
 u16 val, int axis)
>=20
> Hmm. I'm not a great fun of big hydra functions to handle differences
> between devices.  This could easily all be one code flow with some
> lookups into chip specific constant data (as btw could a lot of
> the other switch statements in the existing driver).

I'll try to implement the chip_info approach. This should become a
separate patch.

Concerning the patchset, I would prefer to introduce the chip_info
approach rather late. That would mean to leave this patch unchanged and
introduce your suggestions later within the patchset. I think it's
easier to follow the changes along the patchset.

However, you probably would prefer to place the chip_info patch rather
early in the patchset?

>>  static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo=
, s32 *yo, s32 *zo)
>>  {
>>  	struct yas5xx_calibration *c =3D &yas5xx->calibration;
>> -	u16 t, x, y1, y2;
>> +	u16 t_ref, t, x, y1, y2;
>>  	/* These are "signed x, signed y1 etc */
>>  	s32 sx, sy1, sy2, sy, sz;
>>  	int ret;
>> @@ -329,16 +330,46 @@ static int yas5xx_get_measure(struct yas5xx *yas=
5xx, s32 *to, s32 *xo, s32 *yo,
>>  	sy1 =3D yas5xx_linearize(yas5xx, y1, 1);
>>  	sy2 =3D yas5xx_linearize(yas5xx, y2, 2);
>> =20
>> -	/*
>> -	 * Temperature compensation for x, y1, y2 respectively:
>> -	 *
>> -	 *          Cx * t
>> -	 * x' =3D x - ------
>> -	 *           100
>> -	 */
>> -	sx =3D sx - (c->Cx * t) / 100;
>> -	sy1 =3D sy1 - (c->Cy1 * t) / 100;
>> -	sy2 =3D sy2 - (c->Cy2 * t) / 100;
>> +	/* Set the temperature reference value (unit: counts) */
>> +	switch (yas5xx->devid) {
>> +	case YAS530_DEVICE_ID:
>> +		t_ref =3D YAS530_20DEGREES;
>=20
> One thought to simplify the divergent flow below.
>=20
> 		t_ref2 =3D 0;
>> +		break;
>> +	case YAS532_DEVICE_ID:
>> +		t_ref =3D YAS532_20DEGREES;
> 		if (yas5xx->version =3D=3D YAS532_VERSION_AC)
> 			t_ref2 =3D YAS432_20DEGREES;
> 		else
> 			t_ref2 =3D 0;

The t_ref2 approach looks confusing to me. Because for the most version
it's "t_ref2 =3D 0", only one version out of four needs this.

Another approach: I would rather introduce t_comp (for compensation). In
the chip_info, for the most version it would be...

        .t_comp =3D t,

=2E.. and for the one variant it would be:

        .t_comp =3D t - t_ref,

A problem: I would include the YAS variants like YAS530, YAS532 etc. in
the chip_info. The versions like "AB" and "AC", on the other hand, I
wouldn't include into the chip_info, instead I would handle these in the
functions. In that case the, "t_comp" thing would need to be done in the
function using an if statement, similar to what you suggested up here.
I'll have a closer look when setting up patchset v4.

> Possibly with moving some of the comments below up here.
> As mentioned below, this stuff would be even better if
> in a chip type specific const structure rather than as code.
> That is have one switch statement in probe that picks from
> an array of=20
>=20
> struct yas5xx_chip_info {
> 	/* COMMENTS ON WHAT these are.. *
> 	u16 tref;
> 	u16 tref2;
> 	int ref_temp_celsius;
> 	int min_temp_celsuis;
> };
> static const struct yas5xx_chip_info[] =3D {
> 	[ENUM value we will use to pick right on in probe] =3D {
> 		...
>=20
> etc

Thanks for writing down what it's supposed to look, that's helpful to
compare with other examples.

=2E..

>> @@ -347,11 +378,37 @@ static int yas5xx_get_measure(struct yas5xx *yas=
5xx, s32 *to, s32 *xo, s32 *yo,
>>  	sy =3D sy1 - sy2;
>>  	sz =3D -sy1 - sy2;
>> =20
>> -	/*
>> -	 * FIXME: convert to Celsius? Just guessing this is given
>> -	 * as 1/10:s of degrees so multiply by 100 to get millicentigrades.
>> -	 */
>> -	*to =3D t * 100;
>> +	/* Process temperature readout */
>> +	switch (yas5xx->devid) {
>> +	case YAS530_DEVICE_ID:
>> +		/*
>> +		 * Raw temperature value t is the number of counts starting
>> +		 * at -62 =C2=B0C. Reference value t_ref is the number of counts
>> +		 * between -62 =C2=B0C and 20 =C2=B0C (82 =C2=B0C range).
> Roll this info into the maths and only have the constants set in the sw=
itch
> statement.  Even better if you just move them into chip specific data s=
o
> look them up directly rather than via a switch of devid.  The whole dri=
ver
> would benefit from moving this stuff to const data rather than switch
> statements all over the place.
>=20
> 	int min_temp_x10 =3D yas5xx->chip_info.min_temp_x10;
> 	const int ref_temp_x10 =3D 200;
>=20
> 	*to =3D (min_temp_x10 + ((ref_temp_x10 - min_temp_x10) * t / t_ref)) *=
 100;
>=20
> That should make the code self explanatory and remove need for the comm=
ents.

I'll have a look and will try to implement this.

=2E..

Kind regards,
Jakob
