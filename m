Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CEB6D3264
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 17:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjDAPiO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 11:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjDAPiN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 11:38:13 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE0B74B
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1OF1gwVwKxRH0Bsbr3sddCdFnvOlwCDqmXr9PbGww6I=;
        b=NPuW8Evm/xgBsYbGTQYqTPvwwmcjLQMqELlVWCF6OWYDQJKcojZTdN7f0Mgj3+bVrpSdjnGfalF
        XZ2j+w2PR0Nkpi25yrPyTdpcF/Dqs1OjsqTUJQKVtvdwv4eUrz5v4hH9b0PD/wKH08vwT0nG3GsID
        nAcw9EqP68lUAzzzs/pxzlYzY1tHAf3ld/0Edu/2lOrKlN+/r9ZxslFjeBht6VldfbIc0n0HpsLE1
        2vf6QgO/8kEanpj2SmS05H30Tx+Vu5m1KYinsv3NLsBxnTxoJDV9DihXHpmu3TS6NjceXr5a0VjZG
        nKhl/m8hbeQS9JnITdfx/cVt9dr9GD0oQYSg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1pidIt-0009NA-DD; Sat, 01 Apr 2023 17:38:07 +0200
Received: from [2a06:4004:10df:0:7ca5:67b9:3ab2:84e3] (helo=smtpclient.apple)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1pidIt-000QhM-17; Sat, 01 Apr 2023 17:38:07 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [Linux-stm32] [PATCH 1/3] iio: adc: stm32-adc: warn if dt uses
 legacy channel config
From:   =?utf-8?Q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>
In-Reply-To: <20230401150455.3e426d1e@jic23-huawei>
Date:   Sat, 1 Apr 2023 17:37:56 +0200
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, lars@metafoo.de,
        alexandre.torgue@foss.st.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Olivier Moysan <olivier.moysan@foss.st.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <57AA344C-3213-469A-8759-78C0D183B5D4@geanix.com>
References: <20230327083449.1098174-1-sean@geanix.com>
 <56c019d4-832e-17e1-19f8-7d8bd927c1bb@foss.st.com>
 <20230401150455.3e426d1e@jic23-huawei>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26862/Sat Apr  1 09:22:47 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> On 1 Apr 2023, at 16.04, Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> On Thu, 30 Mar 2023 17:30:32 +0200
> Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
>=20
>> On 3/27/23 10:34, Sean Nyekjaer wrote:
>>> Since nearly all stm32 dt's are using the legacy adc channel config,
>>> we should warn users about using it.
>>>=20
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>> ---
>>> drivers/iio/adc/stm32-adc.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>=20
>>> diff --git a/drivers/iio/adc/stm32-adc.c =
b/drivers/iio/adc/stm32-adc.c
>>> index 1aadb2ad2cab..d8e755d0cc52 100644
>>> --- a/drivers/iio/adc/stm32-adc.c
>>> +++ b/drivers/iio/adc/stm32-adc.c
>>> @@ -1993,6 +1993,8 @@ static int =
stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
>>> const struct stm32_adc_info *adc_info =3D adc->cfg->adc_info;
>>> int num_channels =3D 0, ret;
>>>=20
>>> + dev_warn(&indio_dev->dev, "using legacy channel config\n");
>>> + =20
>>=20
>> Hi Sean,
>>=20
>> I'd recommend to avoid adding a dev_warn() on a per driver basis, for
>> depreacted DT properties. Still I'm not sure if there's some policy =
in
>> this area.
>>=20
>> IMHO, deprecated properties should be checked by using dt tools
>> (dt_binding_check / dtbs_check or other mean?). But I have no idea if
>> this is going to report warnings and when. Purpose would be to avoid
>> introducing no dts files with these. As commented by Olivier on Patch =
3,
>> we've some downstream patches to adopt the generic bindings (not
>> upstream 'yet').
>>=20
>> Another downside is regarding backward compatibility. In case an old =
dtb
>> is used to boot the kernel, as long as there's no functionality loss,
>> I'd advise not to use any warning here. That's a valid use of an old =
dt.
>>=20
>> In all case, thanks for pointing issues (e.g. Patch 2 & 3), regarding
>> this patch, I'd nack adding this warning. Please drop this change if =
you
>> re-submit or turn this into a dev_dbg().
>>=20
>=20
> Agreed. Better to change to dev_dbg().
>=20
> Other two patches look good to me, but will leave a bit more time for =
others
> to comment before I pick them up.  As a small side note. They are =
fixes and
> this first patch is not, so they should have been before it in the =
series
> so I can route them to mainline faster than the non fix.
>=20
> Jonathan

Hi Jonathan,

I=E2=80=99ll resubmit the first patch with dev_dbg() as a single commit, =
and then the fixes as a separate series :)

/Sean

>=20
>> Best Regards,
>> Fabrice
>>=20
>>> ret =3D device_property_count_u32(dev, "st,adc-channels");
>>> if (ret > adc_info->max_channels) {
>>> dev_err(&indio_dev->dev, "Bad st,adc-channels?\n"); =20



