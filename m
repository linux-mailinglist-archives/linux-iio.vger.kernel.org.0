Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E927182AD
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfEHXWs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 19:22:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38927 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfEHXWs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 May 2019 19:22:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so140653plm.6
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2019 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0dqNZfNpiVvA4CpPbArkMRFkpJeCyXIWnwTaD6mUwY=;
        b=IQWYMcYv7mtiGFbLr0eJ8XqY/U5XOI6n0lH7e4tqGbDzLAIX7U3yr9+o7gPifcVrvd
         QT3ytUORGHRkXJ6DU4wCEynfFV+iA5wgOtsz9E63B+rVEmFRlt1idMuTeLJ//lTJSV2Y
         QKbsezoDo4OspQixzJfBEFNeO08arTEw2G74drpySBmeHTEJr5UzCHyhXYSxWjFgr6Pm
         lMNUb9VwM1+I43se7zy+o0OeRlgnP+OGixvnOBs16SVuPILdNJuQAJc7ki3dE7Dh5ZWo
         cOMg2ANFNjijfvUO1m/CgIlU+nOKd3ZJyS5wkkTVClUPJS4aCLoR382QTKrl+MHcYYkM
         K4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0dqNZfNpiVvA4CpPbArkMRFkpJeCyXIWnwTaD6mUwY=;
        b=FJzVd7xKrurALChdwcVkxjY6+2GeuiT93vnw36NAKlTcQg4DfnD7GWYYGgnA1un4oB
         9L8kxfhYtnLfxeFw8DmuYd9KElSU6M3jgyyGFplyC+5uAstgH2/DEJ9lYKE5TrDrglA/
         iC8fia+ItTHhani60Mnrl+TtUzzTh3FKYUQJpSOBUpC3M4nzO49x+02OMYIrbEJwseDO
         Bo+FSM1nbPkfL9PtIwkz9PAgL5ggB21cxo6LznEoJj0oAuNIru2NkOXcW8TMT3cWpiqj
         7JZ9sfI7FSkXT15Z6PJ7p9uPLiSWaqX0LNKVgpFpwxDDaW8/hztzoOFrptBCU/ub0PfG
         DZJg==
X-Gm-Message-State: APjAAAV7Kh+jhUsjK0zKmvYAr4168XR/WsvwEUK8xlJtmZKTh3hPvvwZ
        Q6u0mabcfIynw42J32w6Eo1Q4Q==
X-Google-Smtp-Source: APXvYqxxVGFKybsNdoXRBEXSjZIirCu6WEV3yHiY1Lmtj6dVNfAk/EWOAU4AGPg5i9njvoGbD+1edQ==
X-Received: by 2002:a17:902:102a:: with SMTP id b39mr621019pla.188.1557357766236;
        Wed, 08 May 2019 16:22:46 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id n184sm460626pfn.21.2019.05.08.16.22.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 16:22:44 -0700 (PDT)
Date:   Wed, 8 May 2019 16:22:39 -0700
From:   Benson Leung <bleung@google.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 24/30] mfd: cros_ec: Add API for EC-EC communication
Message-ID: <20190508232239.GB41543@google.com>
References: <20190503220233.64546-1-gwendal@chromium.org>
 <20190503220233.64546-25-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <20190503220233.64546-25-gwendal@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal,

Really tiny commit message nit, otherwise look good.

On Fri, May 03, 2019 at 03:02:27PM -0700, Gwendal Grignou wrote:
> Allow EC to talk to other ECs that are not presented to the host.
> Neeed when EC are present in detachable keyboard.

s/Neeed/Needed


Thanks,
Benson
>=20
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 95 ++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>=20
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index 59ad6bae3f9b..52fd9bfafc7f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -5043,6 +5043,101 @@ struct ec_response_pd_chip_info_v1 {
>  	};
>  } __ec_align2;
> =20
> +/***********************************************************************=
******/
> +/* EC-EC communication commands: range 0x0600-0x06FF */
> +
> +#define EC_COMM_TEXT_MAX 8
> +
> +/*
> + * Get battery static information, i.e. information that never changes, =
or
> + * very infrequently.
> + */
> +#define EC_CMD_BATTERY_GET_STATIC 0x0600
> +
> +/**
> + * struct ec_params_battery_static_info - Battery static info parameters
> + * @index: Battery index.
> + */
> +struct ec_params_battery_static_info {
> +	uint8_t index;
> +} __ec_align_size1;
> +
> +/**
> + * struct ec_response_battery_static_info - Battery static info response
> + * @design_capacity: Battery Design Capacity (mAh)
> + * @design_voltage: Battery Design Voltage (mV)
> + * @manufacturer: Battery Manufacturer String
> + * @model: Battery Model Number String
> + * @serial: Battery Serial Number String
> + * @type: Battery Type String
> + * @cycle_count: Battery Cycle Count
> + */
> +struct ec_response_battery_static_info {
> +	uint16_t design_capacity;
> +	uint16_t design_voltage;
> +	char manufacturer[EC_COMM_TEXT_MAX];
> +	char model[EC_COMM_TEXT_MAX];
> +	char serial[EC_COMM_TEXT_MAX];
> +	char type[EC_COMM_TEXT_MAX];
> +	/* TODO(crbug.com/795991): Consider moving to dynamic structure. */
> +	uint32_t cycle_count;
> +} __ec_align4;
> +
> +/*
> + * Get battery dynamic information, i.e. information that is likely to c=
hange
> + * every time it is read.
> + */
> +#define EC_CMD_BATTERY_GET_DYNAMIC 0x0601
> +
> +/**
> + * struct ec_params_battery_dynamic_info - Battery dynamic info paramete=
rs
> + * @index: Battery index.
> + */
> +struct ec_params_battery_dynamic_info {
> +	uint8_t index;
> +} __ec_align_size1;
> +
> +/**
> + * struct ec_response_battery_dynamic_info - Battery dynamic info respon=
se
> + * @actual_voltage: Battery voltage (mV)
> + * @actual_current: Battery current (mA); negative=3Ddischarging
> + * @remaining_capacity: Remaining capacity (mAh)
> + * @full_capacity: Capacity (mAh, might change occasionally)
> + * @flags: Flags, see EC_BATT_FLAG_*
> + * @desired_voltage: Charging voltage desired by battery (mV)
> + * @desired_current: Charging current desired by battery (mA)
> + */
> +struct ec_response_battery_dynamic_info {
> +	int16_t actual_voltage;
> +	int16_t actual_current;
> +	int16_t remaining_capacity;
> +	int16_t full_capacity;
> +	int16_t flags;
> +	int16_t desired_voltage;
> +	int16_t desired_current;
> +} __ec_align2;
> +
> +/*
> + * Control charger chip. Used to control charger chip on the slave.
> + */
> +#define EC_CMD_CHARGER_CONTROL 0x0602
> +
> +/**
> + * struct ec_params_charger_control - Charger control parameters
> + * @max_current: Charger current (mA). Positive to allow base to draw up=
 to
> + *     max_current and (possibly) charge battery, negative to request cu=
rrent
> + *     from base (OTG).
> + * @otg_voltage: Voltage (mV) to use in OTG mode, ignored if max_current=
 is
> + *     >=3D 0.
> + * @allow_charging: Allow base battery charging (only makes sense if
> + *     max_current > 0).
> + */
> +struct ec_params_charger_control {
> +	int16_t max_current;
> +	uint16_t otg_voltage;
> +	uint8_t allow_charging;
> +} __ec_align_size1;
> +
>  /***********************************************************************=
******/
>  /*
>   * Reserve a range of host commands for board-specific, experimental, or
> --=20
> 2.21.0.1020.gf2820cf01a-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzTZL8ACgkQHwn1ewov
5lgliBAAi2Xkq93LTZDfzRbcO20fikTdY5Os7wvDskLQqxOhuCQegTvlsMT5H4NZ
CHowvQYqTXOJHnAVO9PdwZ52a6LXuvFf6mHrHlS1wKHVnBaWoUvY1mbPT8OMXaWf
ixJ8adShf43SdVP7IPjj5HPYv3qdCknqOGJMonUjNM2FFn5YXjYbtOFjwrOohdMT
iGoy2TOxpb8j5LK/Kgnzy5i9BcSQ1QkNggBedPoM/jRHw7IE/WKO4X1L9HLiHcVy
UuvYMSAzRVP+80HbMCAAjBvrmD3ngVyHvIjVl5jcjpw2JkpayMpCHWHAIU2hKjN5
qehGEdME9Uy8pwdab3n/7fuH+blawfCKjI73oyYly4xkbvRDlWCXRhKGMQMbBTMR
s60Bjl4TXQfyrWzivPATHaH55OXiQa6dsmcOz0c64+jMTi0AEgBTuR6g9FwEBe23
fqRO4sapql8jaq4K6jyvurM8ElrjF0ubTXHsTUD2n9bPxbk48KhwtEetzzKuAVit
I4BrnNZQV8yXfoiYRB839bGdKHgxIR19PA8xP+64I5UfKWyCzIq9flSjgFMlA35T
7AUol4jfr36gJppK1hdZW3VPEcpA/5MycUc00vRqzM5AkiqUvIeaxuvlFSWpUkl9
VDy1jzZ0pW9JlAboUear7pyrRaP3uZfrjwVCYFqC2zJXaedFmko=
=krvY
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
