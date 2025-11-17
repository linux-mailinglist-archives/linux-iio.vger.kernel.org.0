Return-Path: <linux-iio+bounces-26266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D51C64042
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 13:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F60A342A82
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A10329C40;
	Mon, 17 Nov 2025 12:18:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B78279DC8
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381912; cv=none; b=b6frPtVgWb1v5CGdD5sK7wb+FCWfu2dsJScXqhUDNcFbFcMa6c5v0yYlJ6osv+zUc1QwMMy0ZNYVfwwlSdLaFfBGlevb+F63sgjJ0kCOV26RRrEX6kWVZF4xRkdABJeQJuUME5m5Sog+zm1lWMnbBPxU1jfHdTHrpbZqQhPLa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381912; c=relaxed/simple;
	bh=67T+4uBdJ6G54kF4A3sVxn69446l+Y9BVvmZeUDbxtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF+Va8KzI4eDoFal540KMJn5x2hNESGHmylUlx+9Ttqtam6W/KbpdU8R6Et9MZnBldBD+jot6CH3omvKUUX/rA6cAHpY2SOD+eKERS7uhELDVZGpGhdg+yXC6yt25rpkldY0cbJ+DDAN8N44Rg5i5CdgpO4jure3q5sb3JlaFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vKyBd-0004oU-KH; Mon, 17 Nov 2025 13:18:25 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vKyBc-000uSM-2A;
	Mon, 17 Nov 2025 13:18:24 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vKyBc-008Jeh-1o;
	Mon, 17 Nov 2025 13:18:24 +0100
Date: Mon, 17 Nov 2025 13:18:24 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <aRsSkGLO2ELzgca_@pengutronix.de>
References: <20251114092000.4058978-1-o.rempel@pengutronix.de>
 <20251114092000.4058978-3-o.rempel@pengutronix.de>
 <CAHp75Vcjv=XerYsunKO7h_e_jBMQuaKvkvRAuPLAXLqevM4jMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vcjv=XerYsunKO7h_e_jBMQuaKvkvRAuPLAXLqevM4jMw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Fri, Nov 14, 2025 at 08:24:23PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 14, 2025 at 11:20 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > +config TI_ADS131M02
> > +       tristate "Texas Instruments ADS131M02"
> > +       depends on SPI && COMMON_CLK && REGULATOR
> 
> Hmm... The COMMON_CLK looks strange here. Why?

I can drop it, but the driver will fail without proper clock
configuration anyways.

> > +       select CRC_ITU_T
> 
> Btw, why does it not use regmap?

I already answered it here:
https://lore.kernel.org/all/aQ3J_rJV-hB2nh91@pengutronix.de/

> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/clk.h>
> > +#include <linux/crc-itu-t.h>
> > +#include <linux/delay.h>
> > +#include <linux/dev_printk.h>
> 
> > +#include <linux/device.h>
> 
> Is it used? I haven't found what API or data structure is required from here.
> 
> > +#include <linux/device/devres.h>
> > +#include <linux/err.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/lockdep.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> 
> ...
> 
> > +#define ADS131M_CMD_RREG_OP            0xa000
> > +#define ADS131M_CMD_WREG_OP            0x6000
> 
> These two have bit 13 always set. What is the meaning of that bit?

Dokumentation do not provides this information.

> 
> > +#define ADS131M_CMD_RREG(a, n) \
> > +       (ADS131M_CMD_RREG_OP | \
> > +        FIELD_PREP(ADS131M_CMD_ADDR_MASK, a) | \
> > +        FIELD_PREP(ADS131M_CMD_NUM_MASK, n))
> > +#define ADS131M_CMD_WREG(a, n) \
> > +       (ADS131M_CMD_WREG_OP | \
> > +        FIELD_PREP(ADS131M_CMD_ADDR_MASK, a) | \
> > +        FIELD_PREP(ADS131M_CMD_NUM_MASK, n))
> 
> ...
> 
> > +/**
> > + * ads131m_tx_frame_unlocked - Sends a command frame with Input CRC
> > + * @priv: Device private data structure.
> > + * @command: The 16-bit command to send (e.g., NULL, RREG, RESET).
> > + *
> > + * This function sends a command in Word 0, and its calculated 16-bit
> > + * CRC in Word 1, as required when Input CRC is enabled.
> > + *
> > + * Return: 0 on success, or a negative error code from spi_sync.
> 
> spi_sync()
> 
> But I would drop it as it makes dependency on the code changes and it
> will deviate easily if code grows and something else becomes a call
> that returns an error, also this simply doesn't scale: are you going
> to list whole bunch of APIs in the kernel doc? (rhetorical Q) Ditto
> for other similar cases.

ack

> > +static int ads131m_hw_reset(struct ads131m_priv *priv)
> > +       ret = gpiod_set_value_cansleep(priv->reset_gpio, 0);
> > +       if (ret < 0)
> > +               return dev_err_probe(dev, ret, "Failed to deassert reset GPIO\n");
> > +
> > +       /* Wait t_REGACQ (5us) for registers to be accessible */
> > +       fsleep(ADS131M_RESET_DELAY_US);
> > +
> > +       return 0;
> > +}
> 
> Can you use the reset-gpio driver instead of a custom approach?

I do not have strong option about this right now.

> ...
> 
> > +       /*
> > +        * Get the optional external reference. This schedules regulator_put()
> > +        * automatically.
> > +        */
> > +       priv->refin_supply = devm_regulator_get_optional(dev, "refin");
> > +       ret = PTR_ERR_OR_ZERO(priv->refin_supply);
> > +       if (ret == -ENODEV)
> > +               priv->refin_supply = NULL;
> > +       else if (ret < 0)
> > +               return dev_err_probe(dev, ret, "failed to get refin regulator\n");
> 
> So, will the refin_supply be ever an error pointer? I think no, hence
> why IS_ERR_OR_NULL() in the user somewhere above in the code?

Looks like error pointer:
https://elixir.bootlin.com/linux/v6.18-rc5/source/include/linux/regulator/consumer.h#L351

> > +static int ads131m_parse_clock(struct ads131m_priv *priv, bool *is_xtal)
> > +{
> > +       struct device *dev = &priv->spi->dev;
> > +       int ret;
> > +
> > +       priv->clk = devm_clk_get_enabled(dev, NULL);
> > +       if (IS_ERR(priv->clk))
> > +               return dev_err_probe(dev, PTR_ERR(priv->clk), "clk get enabled failed\n");
> > +
> > +       ret = device_property_match_string(dev, "clock-names", "xtal");
> > +       if (ret == 0) {
> > +               if (!priv->config->supports_xtal)
> > +                       return dev_err_probe(dev, -EINVAL,
> > +                                            "'xtal' clock not supported on this device");
> 
> > +               *is_xtal = true;
> > +
> > +               return 0;
> 
> This...
> 
> > +       } else if (ret > 0) {
> > +               return dev_err_probe(dev, -EINVAL, "'xtal' must be the only or first clock name");
> 
> > +       } else if (ret == -ENODATA) {
> > +               *is_xtal = false;
> > +
> > +               return 0;
> > +       }
> > +
> > +       return dev_err_probe(dev, ret, "failed to read 'clock-names' property");
> 
> ...and this can be deduplicated, so the first one becomes just a check
> for !supports_xtal.
> 
>   if (ret == 0) && !supports_xtal)
>     return dev_err_probe(...);
>   else if (ret > 0)
>     return dev_err_probe(...);
> 
> This one will be modified to
> 
>   else if (ret != -ENODATA)
>     return dev_err_probe(...);
> 
>   *is_xtal = !ret;
>   return ret;

ok.

> > +}
> 
> ...
> 
> > +       config = spi_get_device_match_data(spi);
> 
> > +       if (!config)
> > +               return dev_err_probe(dev, -EINVAL, "No device configuration data found\n");
> 
> Without this code will crash, right? So, I consider this check is
> redundant because any support of any new chip requires this, and if
> one didn't add the driver data, means it wasn't tested (which is a
> good trap on itself during code review).

ok.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

