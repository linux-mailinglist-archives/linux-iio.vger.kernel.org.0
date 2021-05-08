Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B98D376F12
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 05:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhEHDKl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 23:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHDKl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 May 2021 23:10:41 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F76C061574;
        Fri,  7 May 2021 20:09:39 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id h9-20020a4a94090000b02901f9d4f64172so2382943ooi.5;
        Fri, 07 May 2021 20:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZZVUqkHquac1Wjj54lNX3+sEEM5nk4IsB+iHsgz5Lc=;
        b=B7JL28jcAfDU5fnNf0RQIc9yEYnUC7RmNjxds9x6heFoJ/NL8LCusiE3WBPEiflv1D
         kbTBt61W5XE/CYRLjuvxVp6pRZQHBh/C37P6GJGYfOqWcUE39bb11ul93WJbDQbbjXNE
         eRG6F/gbfyQ+AZEkYKwAJ9RU1W1u30lyrPF/MjOf4mpW1eVn18cwwGmSi4s1wezkyyuR
         VSbLHmiVTBSxiT39uzzp2Z7bihpwGnWlUXIgetg4LozNbEAG5zRD+SW49DNcFtuKXn/m
         p2yv31HAmBdgeYqOeQ0H4l2JRpEXla093m7aZmk8E55RaYzHa+RYG1dkeoe5/4SwkDpW
         KhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pZZVUqkHquac1Wjj54lNX3+sEEM5nk4IsB+iHsgz5Lc=;
        b=pQJ2zc1rsiNcCsI1AijtXSMheUMPV0yHszbUXthCVLtix7S0NyElnPyNSe3o0h6qvg
         JxM6UoH2JiUD7TlqSsXC+/Agu9pDKeh9iHnqIlARANEe0LwskDNt/kI6OMA3P544kuAD
         BMjOjkejTP41QftE6eKX6DxfZhi0fzHRg9OegudfXDxTYzsvjALrnbNFwk//kCyEt2Gj
         6XA93J3S74sBtN8loYmstnjltH+s6kt8fSJelAyEDT2usYsee+DeDUOcB705oHkWy7aF
         SOrckhf1to9PyHo7FCI+k7nSS3CdtagH+rrQAaxw8bWKgj77yc4N/86Q7+cfpV6CsBzj
         3mig==
X-Gm-Message-State: AOAM530WQqukNy5PXpUyMjMQBASSNFcCA8d0mpkjyN5W/70b6uj0zWHQ
        vdFttAy+AGfrD/SBJvWG3eddLeNwejM=
X-Google-Smtp-Source: ABdhPJwbgtQhG4vyU3WTUhxnK+XB1GmxRRA0pOGjjMsDRC9c9DZXnh2fJeWcydeq7vnIrtqbel+YCg==
X-Received: by 2002:a4a:4bc2:: with SMTP id q185mr10273520ooa.19.1620443379124;
        Fri, 07 May 2021 20:09:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x24sm1584490otq.34.2021.05.07.20.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 20:09:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 May 2021 20:09:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
Message-ID: <20210508030936.GA3879276@roeck-us.net>
References: <20210506034332.752263-1-linux@roeck-us.net>
 <20210507103154.00006763@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507103154.00006763@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 07, 2021 at 10:31:54AM +0100, Jonathan Cameron wrote:
> On Wed,  5 May 2021 20:43:32 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > With CONFIG_ACPI=n and -Werror, 0-day reports:
> > 
> > drivers/iio/chemical/bme680_i2c.c:46:36: error:
> > 	'bme680_acpi_match' defined but not used
> > 
> > Apparently BME0680 is not a valid ACPI ID. Remove it and with it
> > ACPI support from the bme680_i2c driver.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> A note for these is that I'll change the patch titles when applying.
> We aren't removing ACPI support from the drivers, we are simply
> removing the ACPI ID table entries.  For most of these PRP0001 magic
> will work just fine with the OF table.  That's probably the
> right way for small companies etc to use these in products without
> having to jump through the hoops of getting an ACPI ID.
> 

Below is what Coccinelle tells me about ACPI IDs in drivers/iio.
The script (tries) to do a prefix match of all ACPI IDs it finds against
the PNP and ACPI ID databases from https://uefi.org/PNP_ACPI_Registry.

Andy, Hans, does that look about right ?

Next question is what to do with the mismatches and with false
negatives such as:

drivers/iio/accel/stk8312.c
  STK8312: match (prefix) against STK (SANTAK CORP.)
drivers/iio/light/isl29018.c
  ISL29018: match (prefix) against ISL (Isolation Systems)
  ISL29023: match (prefix) against ISL (Isolation Systems)
  ISL29035: match (prefix) against ISL (Isolation Systems)
drivers/iio/gyro/bmg160_i2c.c
  BMI055B: match (prefix) against BMI (Benson Medical Instruments Company)
  BMI088B: match (prefix) against BMI (Benson Medical Instruments Company)

[ and how to auto-detect those - any idea ? ]

If you like I'll be happy to send you the coccinelle script I wrote
to play with.

Guenter

---
drivers/iio/light/stk3310.c
  STK3310: match (prefix) against STK (SANTAK CORP.)
  STK3311: match (prefix) against STK (SANTAK CORP.)
  STK3335: match (prefix) against STK (SANTAK CORP.)
drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
  INVN6000: match (ACPI ID) against INVN (Invensense, Inc)
drivers/iio/imu/fxos8700_i2c.c
  FXOS8700: No match
drivers/iio/dac/ad5592r.c
  ADS5592: match (prefix) against ADS (Analog Devices Inc)
drivers/iio/accel/stk8312.c
  STK8312: match (prefix) against STK (SANTAK CORP.)
drivers/iio/light/us5182d.c
  USD5182: match (prefix) against USD (U.S. Digital Corporation)
drivers/iio/imu/fxos8700_spi.c
  FXOS8700: No match
drivers/iio/dac/ad5593r.c
  ADS5593: match (prefix) against ADS (Analog Devices Inc)
drivers/iio/accel/stk8ba50.c
  STK8BA50: match (prefix) against STK (SANTAK CORP.)
drivers/iio/accel/bma220_spi.c
  BMA0220: No match
drivers/iio/magnetometer/ak8975.c
  AK8975: No match
  AK8963: No match
  INVN6500: match (ACPI ID) against INVN (Invensense, Inc)
  AK009911: No match
  AK09911: No match
  AKM9911: match (prefix) against AKM (Asahi Kasei Microsystems Company Ltd)
  AK09912: No match
drivers/iio/imu/bmi160/bmi160_i2c.c
  BMI0160: match (prefix) against BMI (Benson Medical Instruments Company)
drivers/iio/chemical/bme680_i2c.c
  BME0680: No match
drivers/iio/accel/mxc6255.c
  MXC6225: No match
  MXC6255: No match
drivers/iio/accel/da280.c
  MIRAACC: match (prefix) against MIR (Miro Computer Prod.)
drivers/iio/proximity/sx9310.c
  STH9310: match (prefix) against STH (Semtech Corporation)
  STH9311: match (prefix) against STH (Semtech Corporation)
drivers/iio/accel/bmc150-accel-i2c.c
  BSBA0150: No match
  BMC150A: No match
  BMI055A: match (prefix) against BMI (Benson Medical Instruments Company)
  BMA0255: No match
  BMA250E: No match
  BMA222: No match
  BMA222E: No match
  BMA0280: No match
  BOSC0200: match (ACPI ID) against BOSC (Robert Bosch GmbH)
drivers/iio/light/rpr0521.c
  RPR0521: No match
drivers/iio/humidity/hts221_i2c.c
  SMO9100: match (prefix) against SMO (STMicroelectronics)
drivers/iio/adc/ti-adc108s102.c
  INT3495: match (prefix) against INT (Interphase Corporation)
drivers/iio/accel/kxcjk-1013.c
  KXCJ1013: No match
  KXCJ1008: No match
  KXCJ9000: No match
  KIOX0008: match (ACPI ID) against KIOX (Kionix, Inc.)
  KIOX0009: match (ACPI ID) against KIOX (Kionix, Inc.)
  KIOX000A: match (ACPI ID) against KIOX (Kionix, Inc.)
  KIOX010A: match (ACPI ID) against KIOX (Kionix, Inc.)
  KIOX020A: match (ACPI ID) against KIOX (Kionix, Inc.)
  KXTJ1009: No match
  KXJ2109: No match
  SMO8500: match (prefix) against SMO (STMicroelectronics)
drivers/iio/magnetometer/mmc35240.c
  MMC35240: No match
drivers/iio/light/apds9960.c
  MSHW0184: match (ACPI ID) against MSHW (Microsoft Corporation)
drivers/iio/accel/bmc150-accel-spi.c
  BSBA0150: No match
  BMC150A: No match
  BMI055A: match (prefix) against BMI (Benson Medical Instruments Company)
  BMA0255: No match
  BMA250E: No match
  BMA222: No match
  BMA222E: No match
  BMA0280: No match
drivers/iio/proximity/sx9500.c
  SSX9500: No match
  SASX9500: match (prefix) against SAS (Stores Automated Systems Inc)
drivers/iio/imu/bmi160/bmi160_spi.c
  BMI0160: match (prefix) against BMI (Benson Medical Instruments Company)
drivers/iio/chemical/bme680_spi.c
  BME0680: No match
drivers/iio/accel/mxc4005.c
  MXC4005: No match
  MXC6655: No match
drivers/iio/pressure/hp206c.c
  HOP206C: No match
drivers/iio/light/isl29018.c
  ISL29018: match (prefix) against ISL (Isolation Systems)
  ISL29023: match (prefix) against ISL (Isolation Systems)
  ISL29035: match (prefix) against ISL (Isolation Systems)
drivers/iio/accel/mma9551.c
  MMA9551: match (prefix) against MMA (Micromedia AG)
drivers/iio/potentiometer/max5487.c
  MAX5487: match (prefix) against MAX (Rogen Tech Distribution Inc)
  MAX5488: match (prefix) against MAX (Rogen Tech Distribution Inc)
  MAX5489: match (prefix) against MAX (Rogen Tech Distribution Inc)
drivers/iio/light/jsa1212.c
  JSA1212: No match
drivers/iio/imu/kmx61.c
  KMX61021: No match
drivers/iio/pressure/st_pressure_i2c.c
  SNO9210: match (prefix) against SNO (SINOSUN TECHNOLOGY CO., LTD)
drivers/iio/light/pa12203001.c
  TXCPA122: No match
drivers/iio/light/cm32181.c
  CPLM3218: match (ACPI ID) against CPLM (Capella Microsystems Inc.)
drivers/iio/humidity/am2315.c
  AOS2315: No match
drivers/iio/accel/st_accel_i2c.c
  SMO8840: match (prefix) against SMO (STMicroelectronics)
  SMO8A90: match (prefix) against SMO (STMicroelectronics)
drivers/iio/accel/mma7660.c
  MMA7660: match (prefix) against MMA (Micromedia AG)
drivers/iio/magnetometer/bmc150_magn_spi.c
  BMC150B: No match
  BMC156B: No match
  BMM150B: No match
drivers/iio/light/max44000.c
  MAX44000: match (prefix) against MAX (Rogen Tech Distribution Inc)
drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
  INVN6500: match (ACPI ID) against INVN (Invensense, Inc)
drivers/iio/gyro/bmg160_i2c.c
  BMG0160: No match
  BMI055B: match (prefix) against BMI (Benson Medical Instruments Company)
  BMI088B: match (prefix) against BMI (Benson Medical Instruments Company)
drivers/iio/adc/ti-adc128s052.c
  AANT1280: match (ACPI ID) against AANT (AAEON Technology Inc.)
drivers/iio/accel/mma9553.c
  MMA9553: match (prefix) against MMA (Micromedia AG)
drivers/iio/magnetometer/bmc150_magn_i2c.c
  BMC150B: No match
  BMC156B: No match
  BMM150B: No match
drivers/iio/light/ltr501.c
  LTER0501: No match
  LTER0559: No match
  LTER0301: No match

