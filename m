Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242363B0A1
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 10:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfFJIUU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 04:20:20 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40211 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbfFJIUQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jun 2019 04:20:16 -0400
Received: by mail-wr1-f42.google.com with SMTP id p11so8183724wre.7
        for <linux-iio@vger.kernel.org>; Mon, 10 Jun 2019 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s4CuSQBNjpCCNw2nzrPLspN54vVYUiRnMZOt2mADAck=;
        b=ShN/wlRZ6+T44YTTak7qIefyrWi2CFZpPHiFhwCs+6agNStIZl1VrtoRnwiAM0giZH
         IAwfc0CH0F4tiD3rFC4avNyeVdYZ6SnX2Bq/7D/tKM+S6r1BRT2JYQ6XNmpvZ/nizexF
         0lnXpdRjyFe0c1z5FobfClGzY0GDVCh5ptL25eI7JnK8KFmopfny2JNzAT0J9JElyoxP
         7NGTznHV5Rjbx7fviSoZ1YLTCNdo1WxzQwPTEm5ygMLqr2hjqAnGLHRUXs3O9Ffpi8Ck
         jb/Fe1KXTTaiFa7yR3iziFOKj8R2lcOeLwmPPYpJAwkVTiPZEHiKSRAizxcp7h1NgrsV
         1eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s4CuSQBNjpCCNw2nzrPLspN54vVYUiRnMZOt2mADAck=;
        b=jLxz0mKSAOA+qwVNPhjHUwj66BAlP+brLAJyXMbniFa8Thk7GcX/IB1aD89KQ0HuZM
         hmDSpH56VxqGdnl2a7Bmb5R8clfd7aBVIKLIjukWu85Z3hDv39JHyGBb9B79tTFuIsg3
         eDrUdms08UZnUX49YAPo2ulp2K2I4TwxMsBXCRUo29Y7A/9DjIMPTw5JhUVP+HHcYLG6
         NrvZU23dm4sN91bZURc+1kQlx1B2upJXsfw8/mNO5vjAMMcCU5/ER5TRvze2EOmSCqk5
         +VzEB6dZeSMlZut3vnSXkTn6lEhnkJ7+4masOJzreFTIcQcu5dU5WFMVt1UXwSrGguUw
         92+Q==
X-Gm-Message-State: APjAAAU1JH/5Hn4Yv1h1lyn23suUMcEMzDF6u7xsyQRVQOG3wuoN+YO3
        5P/a/4gdv9hgGsPeuzdh5OuN+g==
X-Google-Smtp-Source: APXvYqwZMgo/mIX2mHjN3PTc4kasBDUVDC60B5GI5hdZc40wSrHoaFk89PunjVBNxAjDf3jnFeSU0Q==
X-Received: by 2002:a5d:53d2:: with SMTP id a18mr17554731wrw.98.1560154814655;
        Mon, 10 Jun 2019 01:20:14 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id o185sm14013441wmo.45.2019.06.10.01.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 01:20:13 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:20:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
        fabien.lahoudere@collabora.com, Takashi Iwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [GIT PULL] Immutable branch between MFD and Cros due for the v5.3
 merge window
Message-ID: <20190610082012.GK4797@dell>
References: <20190603183401.151408-1-gwendal@chromium.org>
 <20190604055908.GA4797@dell>
 <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As requested.

Enjoy!

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-v5.3

for you to fetch changes up to 3aa6be30da899619c44aa654313ba66eb44e7291:

  mfd: cros_ec: Update I2S API (2019-06-10 09:15:08 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Cros due for the v5.3 merge window

----------------------------------------------------------------
Gwendal Grignou (30):
      mfd: cros_ec: Update license term
      mfd: cros_ec: Zero BUILD_ macro
      mfd: cros_ec: set comments properly
      mfd: cros_ec: add ec_align macros
      mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
      mfd: cros_ec: use BIT macro
      mfd: cros_ec: Update ACPI interface definition
      mfd: cros_ec: move HDMI CEC API definition
      mfd: cros_ec: Remove zero-size structs
      mfd: cros_ec: Add Flash V2 commands API
      mfd: cros_ec: Add PWM_SET_DUTY API
      mfd: cros_ec: Add lightbar v2 API
      mfd: cros_ec: Expand hash API
      mfd: cros_ec: Add EC transport protocol v4
      mfd: cros_ec: Complete MEMS sensor API
      mfd: cros_ec: Fix event processing API
      mfd: cros_ec: Add fingerprint API
      mfd: cros_ec: Fix temperature API
      mfd: cros_ec: Complete Power and USB PD API
      mfd: cros_ec: Add API for keyboard testing
      mfd: cros_ec: Add Hibernate API
      mfd: cros_ec: Add Smart Battery Firmware update API
      mfd: cros_ec: Add I2C passthru protection API
      mfd: cros_ec: Add API for EC-EC communication
      mfd: cros_ec: Add API for Touchpad support
      mfd: cros_ec: Add API for Fingerprint support
      mfd: cros_ec: Add API for rwsig
      mfd: cros_ec: Add SKU ID and Secure storage API
      mfd: cros_ec: Add Management API entry points
      mfd: cros_ec: Update I2S API

 include/linux/mfd/cros_ec_commands.h | 3658 +++++++++++++++++++++++++++-------
 sound/soc/codecs/cros_ec_codec.c     |    8 +-
 2 files changed, 2915 insertions(+), 751 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
