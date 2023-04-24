Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA796ECAB4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Apr 2023 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDXKwi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Apr 2023 06:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDXKwh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2023 06:52:37 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B633593;
        Mon, 24 Apr 2023 03:52:20 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 12950100009;
        Mon, 24 Apr 2023 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682333539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKUWG8XwsHs5cBDxDN0t+v8V3Kca4ChPZTtEEbQ6jZo=;
        b=fPVjkvF+gFpJ7tMj1skmY/E5xkFUo7OQt7yK5LbLJTw6l4i82qIEJkbSwLUhWPptpI/1ye
        LiIk7b8Zot3/gtSCwh7psQskWKgCErmDDX63JoPgqJn0d7rn4MQfZ5fXbyzMZkoKCYhPXS
        xP5QkgnF0/A88IuKccDVlFq855i9FGb7Q4dAt18qiVd7DEfn6eA+fixBF21yofsnkSwIKi
        k2zD1afAaIAZA7MVQxBYwzbphsFfdkHc7MNauwj9jPzY8ToNG7R7vTalnGyASudyaWhqgZ
        xXggGc/tZ4wtPRhmUnPB3sDrpTv1yVkL8Q6fHVR4y7tfCNT2HG3tKhQwQzJehQ==
Date:   Mon, 24 Apr 2023 12:52:16 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/4] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230424125216.0f279f82@bootlin.com>
In-Reply-To: <20230422180814.61d24aa3@jic23-huawei>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
        <20230421124122.324820-5-herve.codina@bootlin.com>
        <20230422180814.61d24aa3@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, Mark,

On Sat, 22 Apr 2023 18:08:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 Apr 2023 14:41:22 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Industrial I/O devices can be present in the audio path.
> > These devices needs to be used as audio components in order to be fully
> > integrated in the audio path.
> > 
> > This support allows to consider these Industrial I/O devices as auxliary
> > audio devices and allows to control them using mixer controls.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> Hi Herve,
> 
> There are some other IIO devices that might turn up in audio paths. In theory
> someone might put an IIO supported amplifier in there (though current ones are
> far to high frequency and expensive for that to make sense).  For now it
> probably makes sense to support potentiometers as you are doing here,
> though I'm guessing that in many cases they would be used with some other
> analog components. Does the transfer function matter at all?
> 
> Been many years since I last touched anything in ASoC so questions may
> be silly ;)
> 
> A few comments inline.
> 
> Jonathan
> 
> > +static int simple_iio_aux_get_volsw(struct snd_kcontrol *kcontrol,
> > +				    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct simple_iio_aux_chan *chan = (struct simple_iio_aux_chan *)kcontrol->private_value;
> > +	int max = chan->max;
> > +	int min = chan->min;
> > +	unsigned int mask = (1 << fls(max)) - 1;  
> 
> As below. I'm not following reason for use of mask
> 
> > +	unsigned int invert = chan->is_inverted;
> > +	int ret;
> > +	int val;
> > +
> > +	ret = iio_read_channel_raw(chan->iio_chan, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ucontrol->value.integer.value[0] = (val & mask) - min;
> > +	if (invert)
> > +		ucontrol->value.integer.value[0] = max - ucontrol->value.integer.value[0];
> > +
> > +	return 0;
> > +}
> > +
> > +static int simple_iio_aux_put_volsw(struct snd_kcontrol *kcontrol,
> > +				    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct simple_iio_aux_chan *chan = (struct simple_iio_aux_chan *)kcontrol->private_value;
> > +	int max = chan->max;
> > +	int min = chan->min;
> > +	unsigned int mask = (1 << fls(max)) - 1;  
> 
> Why is mask needed?  Also seems like handling is making
> some strong assumptions on form of max and min.
> So at minimum some comments on reasoning needed.

This mask was present in the internal ASoC helpers used when
devices can be accessed using regmap.
The IIO accesses done by simple_iio_aux_get_volsw() and 
simple_iio_aux_put_volsw() were based on these internal helpers.
Not sure about the exact reason to this mask. Maybe Mark can answer.

For these particular use-cases using an IIO channel, the mask present in
simple_iio_aux_get_volsw() and simple_iio_aux_put_volsw() can be removed.

I will remove in the next iteration except if Mark tell me to keep them.

> 
> > +	unsigned int invert = chan->is_inverted;
> > +	int val;
> > +	int ret;
> > +	int tmp;
> > +
> > +	val = ucontrol->value.integer.value[0];
> > +	if (val < 0)
> > +		return -EINVAL;
> > +	if (val > max - min)
> > +		return -EINVAL;
> > +
> > +	val = (val + min) & mask;
> > +	if (invert)
> > +		val = max - val;
> > +
> > +	ret = iio_read_channel_raw(chan->iio_chan, &tmp);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (tmp == val)
> > +		return 0;
> > +
> > +	ret = iio_write_channel_raw(chan->iio_chan, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 1; /* The value changed */
> > +}
> > +  
> 
> ...
> 
> 
> 
> > +static int simple_iio_aux_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct simple_iio_aux_chan *iio_aux_chan;
> > +	struct simple_iio_aux *iio_aux;
> > +	int count;
> > +	u32 tmp;
> > +	int ret;
> > +	int i;
> > +
> > +	iio_aux = devm_kzalloc(&pdev->dev, sizeof(*iio_aux), GFP_KERNEL);
> > +	if (!iio_aux)
> > +		return -ENOMEM;
> > +
> > +	iio_aux->dev = &pdev->dev;
> > +
> > +	count = of_property_count_strings(np, "io-channel-names");
> > +	if (count < 0) {
> > +		dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names\n", np);
> > +		return count;
> > +	}
> > +
> > +	iio_aux->chans = devm_kmalloc_array(&pdev->dev, count,
> > +					    sizeof(*iio_aux->chans), GFP_KERNEL);
> > +	if (!iio_aux->chans)
> > +		return -ENOMEM;
> > +	iio_aux->num_chans = count;
> > +
> > +	for (i = 0; i < iio_aux->num_chans; i++) {
> > +		iio_aux_chan = iio_aux->chans + i;
> > +
> > +		ret = of_property_read_string_index(np, "io-channel-names", i,
> > +						    &iio_aux_chan->name);  
> 
> Whilst today this will be tightly couple with of, if you can use generic firmware
> handling where possible (from linux/property.h) it will reduce what needs
> to be tidied up if anyone fills in the gaps for IIO consumer bindings in ACPI
> and then someone uses PRP0001 based ACPI bindings.

No device_property_read_*() function family are available to get a value
from an array using an index.

I would prefer to keep the of_property_read_*() function family I use for this
first IIO auxiliary device support.

> 
> > +		if (ret < 0) {
> > +			dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names[%d]\n", np, i);  
> 
> dev_err_probe() would simplify these cases a little.  Not sure on ASOC view on using
> that for cases that won't defer.  I tend to take the view it's nicer everywhere
> for calls in probe() functions.

I have the feeling that ASoC uses dev_err_probe() for cases that can defer.
Mark, can you confirm ?

> 
> 
> > +			return ret;
> > +		}
> > +
> > +		iio_aux_chan->iio_chan = devm_iio_channel_get(iio_aux->dev, iio_aux_chan->name);
> > +		if (IS_ERR(iio_aux_chan->iio_chan)) {
> > +			ret = PTR_ERR(iio_aux_chan->iio_chan);  
> 
> Put that inline instead of setting ret here.

Will be done in the next iteration.

> 
> > +			return dev_err_probe(iio_aux->dev, ret,
> > +					     "get IIO channel '%s' failed (%d)\n",
> > +					     iio_aux_chan->name, ret);
> > +		}
> > +
> > +		tmp = 0;
> > +		of_property_read_u32_index(np, "invert", i, &tmp);
> > +		iio_aux_chan->is_inverted = !!tmp;  
> 
> As it's a bool this is the same as 
> 		iio_aux_chan->is_inverted = tmp;

I will remove the '!!' construction.


> 
> > +	}
> > +
> > +	platform_set_drvdata(pdev, iio_aux);
> > +
> > +	return devm_snd_soc_register_component(iio_aux->dev,
> > +					       &simple_iio_aux_component_driver,
> > +					       NULL, 0);
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id simple_iio_aux_ids[] = {
> > +	{ .compatible = "simple-iio-aux", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, simple_iio_aux_ids);
> > +#endif
> > +
> > +static struct platform_driver simple_iio_aux_driver = {
> > +	.driver = {
> > +		.name = "simple-iio-aux",
> > +		.of_match_table = of_match_ptr(simple_iio_aux_ids),  
> 
> I'd just drop the of_match_ptr()  Whilst this won't work today with other
> firmwares, we might enable the missing parts at some stage. Also the
> driver is somewhat pointless without DT so I'd just assume it's always
> built with it.  Cost is a tiny array on systems with a weird
> .config

of_match_ptr will be removed (and the #ifdef CONFIG_OF also).

> 
> > +	},
> > +	.probe = simple_iio_aux_probe,
> > +};
> > +
> > +module_platform_driver(simple_iio_aux_driver);
> > +
> > +MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
> > +MODULE_DESCRIPTION("IIO ALSA SoC aux driver");
> > +MODULE_LICENSE("GPL");  
> 

Thanks for the review.

Best regards,
Hervé
