Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8026BEB83
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCQOkk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCQOki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 10:40:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2872D162;
        Fri, 17 Mar 2023 07:40:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g17so6777291lfv.4;
        Fri, 17 Mar 2023 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679064034;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbpLZLJKhIy7G/YVz7UFfFG9vujZXHDX7wwiT21OKeY=;
        b=KhRYk4cnvefedpgfwqKzHuDxnbokHKHkF4xb341zj9pdf8AoDckQa6u983OjvhWLFV
         /WZHxpwjM/wRmsiEuohHPEB8dj7LWHmL91nVL/oFEbrEZP79/xuei6SZngG6+vRIhOSi
         tkMcW/Q6zerPy8mhS7LmPEeypLIdk7u9J1+p/hxL/+aJd1tE78+d/WEB6aTT+0q6LTmD
         bEm2i2sfDjtvrUTXBCic6P14m2Keyx5SmFTamp3MlAHM2V6U/SY9KijZ64/bfz5PhQdY
         fLuFjxm5xAdAq6eoONSYTA3uSndtC/3NPDv67mxFj8vPUWKldYv+0NBldzvE1aKPdzzi
         oFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064034;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbpLZLJKhIy7G/YVz7UFfFG9vujZXHDX7wwiT21OKeY=;
        b=aZHM30QqgC18sdJFvF/GtuIe/jZ3mNiuWnykJkW/GI4aCH/lffpt47FPOFU2DTIZ2W
         kmdtaCK5Ed5Ldrhq9WYaM5M+8gvx7d6P+bsJ8xpd04zxkJ81GEVweCvN0zEoI+rhIEjb
         Ctsy9pSoZcgK7RYEVNksE5UaZ7lRl4waUfOyGd8OGCvIfxh417YOQs3xbrLT7V9fySW2
         MnhLIqzNDBrfrMnkK6A92db/LN7yTtkBe5y+U3kkA7CLDsHm3OJR1xRLFtoUaRYdzfvn
         +Q+MA0S0SjiB/WpzHLAn1E6yYZUJMk6l+lj55M6XRWnOCJX/7flpR8MvxemTayKPHIMx
         lQVw==
X-Gm-Message-State: AO0yUKVQNxj38y9ynpX6aBYiJ75mF/uJq4m5zCmPv4VtW1NTg24Ewlvj
        xtt7jOHUS3cI/sDsWrYq/nA=
X-Google-Smtp-Source: AK7set+aVFjyqSWi/HO0rfECTrHzFyzkAvOZSmlJmP+vAX8uKD5PEq9gMZWKzoHbtD1cO4MUKm512A==
X-Received: by 2002:ac2:483a:0:b0:4db:3ddf:2fc5 with SMTP id 26-20020ac2483a000000b004db3ddf2fc5mr4443314lft.26.1679064033710;
        Fri, 17 Mar 2023 07:40:33 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g14-20020a19ee0e000000b004dc4c5149dasm392051lfb.301.2023.03.17.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:40:33 -0700 (PDT)
Date:   Fri, 17 Mar 2023 16:40:16 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Maxime Ripard <mripard@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Emma Anholt <emma@anholt.net>,
        Liam Beguin <liambeguin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v4 0/8] Support ROHM BU27034 ALS sensor
Message-ID: <cover.1679062529.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vz9y0TSeJG+f9Omp"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Vz9y0TSeJG+f9Omp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BU27034 ALS sensor

This series adds support for ROHM BU27034 Ambient Light Sensor.

The BU27034 has configurable gain and measurement (integration) time
settings. Both of these have inversely proportional relation to the
sensor's intensity channel scale.

Many users only set the scale, which means that many drivers attempt to
'guess' the best gain+time combination to meet the scale. Usually this
is the biggest integration time which allows setting the requested
scale. Typically, increasing the integration time has better accuracy
than increasing the gain, which often amplifies the noise as well as the
real signal.

However, there may be cases where more responsive sensors are needed.
So, in some cases the longest integration times may not be what the user
prefers. The driver has no way of knowing this.

Hence, the approach taken by this series is to allow user to set both
the scale and the integration time with following logic:

1. When scale is set, the existing integration time is tried to be
   maintained as a first priority.
   1a) If the requested scale can't be met by current time, then also
       other time + gain combinations are searched. If scale can be met
       by some other integration time, then the new time may be applied.
       If the time setting is common for all channels, then also other
       channels must be able to maintain their scale with this new time
       (by changing their gain). The new times are scanned in the order
       of preference (typically the longest times first).
   1b) If the requested scale can be met using current time, then only
       the gain for the channel is changed.

2. When the integration time change - scale is tried to be maintained.
   When integration time change is requested also gain for all impacted
   channels is adjusted so that the scale is not changed, or is chaned
   as little as possible. This is different from the RFCv1 where the
   request was rejected if suitable gain couldn't be found for some
   channel(s).

This logic is simple. When total gain (either caused by time or hw-gain)
is doubled, the scale gets halved. Also, the supported times are given a
'multiplier' value which tells how much they increase the total gain.

However, when I wrote this logic in bu27034 driver, I made quite a few
errors on the way - and driver got pretty big. As I am writing drivers
for two other sensors (RGB C/IR + flicker BU27010 and RGB C/IR BU27008)
with similar gain-time-scale logic I thought that adding common helpers
for these computations might be wise. I hope this way all the bugs will
be concentrated in one place and not in every individual driver ;)

Hence, this series also intriduces IIO gain-time-scale helpers
(abbreviated as gts-helpers) + a couple of KUnit tests for the most
hairy parts.

Speaking of which - testing the devm interfaces requires a 'dummy
device'. There were neat helpers in DRM tests for creating and freeing
such a device. This series moves those helpers to more generic location.
What is worth noting is that there is something similar ongoing in the
CCF territory:
https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/
These efforts should be somehow coordinated in order to avoid any ajor
conflicts.

Finally, these added helpers do provide some value also for drivers
which only:
 a) allow gain change
  or
 b) allow changing both the time and gain while trying to maintain the
    scale.

For a) we provide the gain - selector (register value) table format +
selector to gain look-ups, gain <-> scale conversions and the available
scales helpers.

For latter case we also provide the time-tables, and actually all the
APIs should be usable by setting the time multiplier to 1. (not testeted
thoroughly though).

Revision history:
v3 =3D> v4: (Stil ostly fixes to review comments from Andy and Jonathan)
- more accurate change-log in individual patches
- dt-binding and maintainer patches unchanged.
- dropped unused helpers and converted ones currently used only internally
  to static.
- extracted "dummy device" creation helpers from DRM tests.
- added tests for devm APIs
- dropped scale for PROCESSED channel in BU27034 and converted mLux
  values to luxes
- dropped channel 2 GAIN setting which can't be done due to HW
  limitations.

v2 =3D> v3: (Mostly fixes to review comments from Andy and Jonathan)
- dt-binding and maintainer patches unchanged.
- iio-gts-helper tests: Use namespaces
- iio-gts-helpers + bu27034 plenty of changes. See more comprehensive
  changelog in individual patches.

RFCv1 =3D> v2:
  dt-bindings:
	- Fix binding file name and id by using comma instead of a hyphen to
	  separate the vendor and part names.
  gts-helpers:
	- fix include guardian
	- Improve kernel doc for iio_init_iio_gts.
	- Add iio_gts_scale_to_total_gain
	- Add iio_gts_total_gain_to_scale
	- Fix review comments from Jonathan
	  - add documentation to few functions
	  - replace 0xffffffffffffffffLLU by U64_MAX
	  - some styling fixes
	  - drop unnecessary NULL checks
	  - order function arguments by  in / out purpose
	  - drop GAIN_SCALE_ITIME_MS()
	- Add helpers for available scales and times
	- Rename to iio-gts-helpers
  gts-tests:
	- add tests for available scales/times helpers
	- adapt to renamed iio-gts-helpers.h header
  bu27034-driver:
	- (really) protect read-only registers
	- fix get and set gain
	- buffered mode
	- Protect the whole sequences including meas_en/meas_dis to avoid messing
	  up the enable / disable order
	- typofixes / doc improvements
	- change dropped GAIN_SCALE_ITIME_MS() to GAIN_SCALE_ITIME_US()
	- use more accurate scale for lux channel (milli lux)
	- provide available scales / integration times (using helpers).
	- adapt to renamed iio-gts-helpers.h file
	- bu27034 - longer lines in Kconfig
	- Drop bu27034_meas_en and bu27034_meas_dis wrappers.
	- Change device-name from bu27034-als to bu27034
  MAINTAINERS:
	- Add iio-list

---



Matti Vaittinen (8):
  drm/tests: helpers: rename generic helpers
  kunit: drm/tests: move generic helpers
  dt-bindings: iio: light: Support ROHM BU27034
  iio: light: Add gain-time-scale helpers
  iio: test: test gain-time-scale helpers
  MAINTAINERS: Add IIO gain-time-scale helpers
  iio: light: ROHM BU27034 Ambient Light Sensor
  MAINTAINERS: Add ROHM BU27034

 .../bindings/iio/light/rohm,bu27034.yaml      |   46 +
 MAINTAINERS                                   |   14 +
 drivers/base/test/Kconfig                     |    5 +
 drivers/base/test/Makefile                    |    2 +
 drivers/base/test/test_kunit_device.c         |   83 +
 drivers/gpu/drm/Kconfig                       |    2 +
 .../gpu/drm/tests/drm_client_modeset_test.c   |    5 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c     |   69 -
 drivers/gpu/drm/tests/drm_managed_test.c      |    5 +-
 drivers/gpu/drm/tests/drm_modes_test.c        |    5 +-
 drivers/gpu/drm/tests/drm_probe_helper_test.c |    5 +-
 drivers/gpu/drm/vc4/Kconfig                   |    1 +
 drivers/gpu/drm/vc4/tests/vc4_mock.c          |    3 +-
 .../gpu/drm/vc4/tests/vc4_test_pv_muxing.c    |    9 +-
 drivers/iio/Kconfig                           |    3 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/industrialio-gts-helper.c         |  990 +++++++++++
 drivers/iio/light/Kconfig                     |   14 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/rohm-bu27034.c              | 1491 +++++++++++++++++
 drivers/iio/test/Kconfig                      |   16 +
 drivers/iio/test/Makefile                     |    1 +
 drivers/iio/test/iio-test-gts.c               |  461 +++++
 include/drm/drm_kunit_helpers.h               |    7 +-
 include/linux/iio/iio-gts-helper.h            |  113 ++
 25 files changed, 3265 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2703=
4.yaml
 create mode 100644 drivers/base/test/test_kunit_device.c
 create mode 100644 drivers/iio/industrialio-gts-helper.c
 create mode 100644 drivers/iio/light/rohm-bu27034.c
 create mode 100644 drivers/iio/test/iio-test-gts.c
 create mode 100644 include/linux/iio/iio-gts-helper.h


base-commit: eeac8ede17557680855031c6f305ece2378af326
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--Vz9y0TSeJG+f9Omp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQUe8UACgkQeFA3/03a
ocXW3ggAp2mpY09Kd4xD+s9OhWFRMiBr0thNSCpu8pS2natjWbsJk/Bc7hIGeEI2
rvXnSTgXE+9FXhMFCXDUljjk/QMSfLAwtAi6QaZkgDiJqfNEBOh1khUykheAHr2W
dYLY3XybS5V6czWpGh2fLuyiADR1PWZj94vqFk4Z4xXHyvQS4kUOba+CqF+yBOpn
x+NfKG1yYHof8KzeZinVMc8jS8WJXaGIihkDKpgdO4JZmoyBVMjd2//RFnygn+lj
xnEaHdzxx50whoaj9jemCeHBvmjMireu88hp0fACnTnSK+qycvXZziQyUsUjcRW/
twJFP3ic0Y/7nGQFgCxiq4tWNASgRQ==
=6633
-----END PGP SIGNATURE-----

--Vz9y0TSeJG+f9Omp--
