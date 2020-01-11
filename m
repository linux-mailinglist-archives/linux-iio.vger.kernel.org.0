Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860F11380FC
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 11:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgAKK6K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 05:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbgAKK6K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 05:58:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE3E20842;
        Sat, 11 Jan 2020 10:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578740289;
        bh=AwApWeOi444mVnZM57YOAlb1KxKLXOu+enQzYXJLs3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ajtiJFtZaY8yahk0nsLiTWQJgpN6LM0GDSTpMFiiud1w1MrXzGbPiiMMfJ/NgnYKb
         585pueMd/y6sTNKs/7w2+gxVVRLXRnwPXjG6W413+cSbW5ccLqh6jqmjR8jqXVfsFY
         +CoFTBhFojA2bcqEwijnBi8vi740N73mH8X/qcFU=
Date:   Sat, 11 Jan 2020 10:58:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: Use dma_request_chan()
 instead dma_request_slave_channel()
Message-ID: <20200111105804.7aebd43e@archlinux>
In-Reply-To: <5328b668-2522-5d8d-83bb-f99bfe3086ed@st.com>
References: <20200107114532.6697-1-peter.ujfalusi@ti.com>
        <eade6657-8470-0d70-b3c1-fcdddf891c6c@st.com>
        <4c0b7e3e-cd98-860a-e931-c216f1bc6e7a@ti.com>
        <698d9dec-4486-f70a-b8e0-dfd6b4bb907f@st.com>
        <45195b31-70fa-39c9-e109-eeb33d6a2663@ti.com>
        <5328b668-2522-5d8d-83bb-f99bfe3086ed@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 Jan 2020 13:56:14 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 1/9/20 12:40 PM, Peter Ujfalusi wrote:
> >=20
> >=20
> > On 09/01/2020 13.29, Fabrice Gasnier wrote: =20
> >> On 1/9/20 11:32 AM, Peter Ujfalusi wrote: =20
> >>>
> >>>
> >>> On 09/01/2020 11.13, Fabrice Gasnier wrote: =20
> >>>> On 1/7/20 12:45 PM, Peter Ujfalusi wrote: =20
> >>>>> dma_request_slave_channel() is a wrapper on top of dma_request_chan=
()
> >>>>> eating up the error code.
> >>>>>
> >>>>> By using dma_request_chan() directly the driver can support deferred
> >>>>> probing against DMA.
> >>>>>
> >>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>>>> ---
> >>>>> Hi,
> >>>>>
> >>>>> Changes since v1:
> >>>>> - Fall back to IRQ mode for ADC only in case of ENODEV =20
> >>>>
> >>>> Hi Peter,
> >>>>
> >>>> Thanks for the patch,
> >>>>
> >>>> Please find a minor comment here after. Apart from that, you can add=
 my:
> >>>>
> >>>> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >>>>
> >>>> =20
> >>>>>
> >>>>> Regards,
> >>>>> Peter
> >>>>>
> >>>>>  drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++++++++++----
> >>>>>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/st=
m32-dfsdm-adc.c
> >>>>> index e493242c266e..74a2211bdff4 100644
> >>>>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> >>>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> >>>>> @@ -1383,9 +1383,13 @@ static int stm32_dfsdm_dma_request(struct ii=
o_dev *indio_dev)
> >>>>>  {
> >>>>>  	struct stm32_dfsdm_adc *adc =3D iio_priv(indio_dev);
> >>>>> =20
> >>>>> -	adc->dma_chan =3D dma_request_slave_channel(&indio_dev->dev, "rx"=
);
> >>>>> -	if (!adc->dma_chan)
> >>>>> -		return -EINVAL;
> >>>>> +	adc->dma_chan =3D dma_request_chan(&indio_dev->dev, "rx");
> >>>>> +	if (IS_ERR(adc->dma_chan)) {
> >>>>> +		int ret =3D PTR_ERR(adc->dma_chan);
> >>>>> +
> >>>>> +		adc->dma_chan =3D NULL;
> >>>>> +		return ret; =20
> >>>>
> >>>> You may "return PTR_ERR(adc->dma_chan);" directly here. =20
> >>>
> >>> I don't make decision here on behalf of the adc path on to go forward=
 w/
> >>> or w/o DMA support and if we go ahead the stm32_dfsdm_dma_release()
> >>> needs the dma_chan to be NULL in case we don't use DMA.
> >>>
> >>> It is much cleaner to set dma_chan to NULL here than doing it in other
> >>> paths. =20
> >>
> >> Hi Peter, =20
> >=20
> > Hi Fabrice,
> >  =20
> >> Sorry I wasn't clear enough. I agree with you. I was suggesting only,
> >> talking about the 'ret' variable. It may be removed to spare a few lin=
es
> >> :-).
> >> 	if (IS_ERR(adc->dma_chan)) {
> >> 		adc->dma_chan =3D NULL;
> >> 		return PTR_ERR(adc->dma_chan);
> >> 	}
> >> I'm okay both ways. =20
> >=20
> > PTR_ERR(NULL); will return 0
> > I need to retrieve the actual error code before NULLing dma_chan. =20
>=20
> Oh yes, so please forget this.
> Thanks,
> Fabrice

Applied to the togreg branch of iio.git and pushed out as testing.
Note I'll need to rebase once Greg pushes out staging/staging-next
with the changes currently in staging/staging-testing.  Shouldn't
have an effect on this though!

Thanks,

Jonathan

>=20
> >  =20
> >> =20
> >>> =20
> >>>>
> >>>> Best Regards,
> >>>> Fabrice
> >>>> =20
> >>>>> +	}
> >>>>> =20
> >>>>>  	adc->rx_buf =3D dma_alloc_coherent(adc->dma_chan->device->dev,
> >>>>>  					 DFSDM_DMA_BUFFER_SIZE,
> >>>>> @@ -1509,7 +1513,16 @@ static int stm32_dfsdm_adc_init(struct iio_d=
ev *indio_dev)
> >>>>>  	init_completion(&adc->completion);
> >>>>> =20
> >>>>>  	/* Optionally request DMA */
> >>>>> -	if (stm32_dfsdm_dma_request(indio_dev)) {
> >>>>> +	ret =3D stm32_dfsdm_dma_request(indio_dev);
> >>>>> +	if (ret) {
> >>>>> +		if (ret !=3D -ENODEV) {
> >>>>> +			if (ret !=3D -EPROBE_DEFER)
> >>>>> +				dev_err(&indio_dev->dev,
> >>>>> +					"DMA channel request failed with %d\n",
> >>>>> +					ret);
> >>>>> +			return ret;
> >>>>> +		}
> >>>>> +
> >>>>>  		dev_dbg(&indio_dev->dev, "No DMA support\n");
> >>>>>  		return 0;
> >>>>>  	}
> >>>>> =20
> >>>
> >>> - P=C3=A9ter
> >>>
> >>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> >>> =20
> >=20
> > - P=C3=A9ter
> >=20
> > Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> > Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> >  =20

