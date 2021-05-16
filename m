Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDF381FBE
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhEPQWf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:22:35 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:27931 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhEPQWe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 12:22:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621182058; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tdQMvnW1QpFNtIJHGKgq+C/1D2wz0GqmyQComQL8OLeQTy4x7Cv2/pIzIC1AWD5Mhr
    8cvUC1n0J2yetvj2zmQUEVMsij9MAx8MC2a0GXdQH0WdVFKAJGTpugJQM6ebOQRrGeQG
    M5XvoKRz1kqVQTqi8WqGhK/vqzqagIgVLVBqh793B2JWK2EH6jMmb9A2YIcPVRG25JI1
    U3yLuEw42mt3OgSaB2C2vV5xCyR2xcxG0JXJmJnA1Pc6LolPktT7elPNNTKrubtCbt/V
    8rIMrUOW4LqXGRhp1GTIa7RfZewXfDIkyzFbEuH9H1aoAVkG5oEZ1LWB8c0cASDSNJPd
    zreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621182058;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8xQfSOAF2txRJ+rOsHUem74HlTBIEkHLbpPeBXl81qA=;
    b=KoYnHHE5Q/llHXrMcOYLPZzhMJuf+ccqam/bRVbMPv7DRz0NdxjJB0TEsRMBFPR3yN
    cUNmqeqypoj4io+4YnhyXecpcnveIaaz3OPIabUQ24ehUHclaX1BMdVJN0NqTs02i5BY
    wERnlKa2w+5FTI0ZmbHw4lcC1op7kNpgjo/8t5iIOaoGvd97Y/pZtPAnwO86g3Z7Fr/h
    Gx1nvjtHLl22Z17E8jippYo2TWzVThB5vrsihNSXMSbim0F/Ziu3CcgOOa6hGmDO2+Lg
    crUgGBtkd4peKiGUZWTOuumZ21L6YdVxfSHCRFblKhvHaU1cARueHuxPZaDmuGpyIHUU
    /zAQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621182058;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8xQfSOAF2txRJ+rOsHUem74HlTBIEkHLbpPeBXl81qA=;
    b=JGUJZYauQ7UKdkc5OWnuZtwBkZjuMXJoHrjL5jpZgkFI6UbiPWJ8dhYsFlqZ0UrLPw
    XJ3sm25uQpOdD04FLunp7OuVw5x3L4qa8zd8pYlyTbPQlhYKz0h5TOWDUlBD/IDwn9yX
    GqYaQFv1y0OML60b9ouKb0iagI1+bL6Su510M/C9T5lt7UCbLhEAmHBQloeWWm3B5jHL
    qFa1VPlgTr48Ku9xG+EA8YMkMzeIDrqJhYzB0YYPPYHO4VUiGik3IPcl9FyfBLjLSz3x
    lO6C9RIlu+kVBEXMmWOQqV/liKQUNNlj28YLQXnUI9Xx+XB5wQbn5KXZe5ykD60bmgYM
    7qvw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j9IcfMBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id n066b2x4GGKv00y
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 16 May 2021 18:20:57 +0200 (CEST)
Date:   Sun, 16 May 2021 18:20:52 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] iio: accel: st_sensors: Support generic mounting matrix
Message-ID: <YKFGZGYxHyy9dGiJ@gerhold.net>
References: <20210515000058.204601-1-linus.walleij@linaro.org>
 <20210516104808.49a5d3e5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516104808.49a5d3e5@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus,

On Sun, May 16, 2021 at 10:48:08AM +0100, Jonathan Cameron wrote:
> On Sat, 15 May 2021 02:00:58 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > The ST accelerators support a special type of quirky
> > mounting matrix found in ACPI systems, but not a generic
> > mounting matrix such as from the device tree.
> > 
> > Augment the ACPI hack to be a bit more generic and
> > accept a mounting matrix from device properties.
> > 
> > This makes it possible to fix orientation on the Ux500
> > HREF device.
> > 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Denis Ciocca <denis.ciocca@st.com>
> > Cc: Daniel Drake <drake@endlessm.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/iio/accel/st_accel_core.c | 51 ++++++++++++++++++++-----------
> >  1 file changed, 34 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> > index 43c50167d220..cfbcf740e3cb 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -1069,26 +1069,25 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
> >  #define ST_ACCEL_TRIGGER_OPS NULL
> >  #endif
> >  
> > -#ifdef CONFIG_ACPI
> >  static const struct iio_mount_matrix *
> > -get_mount_matrix(const struct iio_dev *indio_dev,
> > -		 const struct iio_chan_spec *chan)
> > +st_accel_get_mount_matrix(const struct iio_dev *indio_dev,
> > +			  const struct iio_chan_spec *chan)
> >  {
> >  	struct st_sensor_data *adata = iio_priv(indio_dev);
> >  
> >  	return adata->mount_matrix;
> >  }
> >  
> > -static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
> > -	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
> > +static const struct iio_chan_spec_ext_info st_accel_mount_matrix_ext_info[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_accel_get_mount_matrix),
> >  	{ },
> >  };
> >  
> > +#ifdef CONFIG_ACPI
> >  /* Read ST-specific _ONT orientation data from ACPI and generate an
> >   * appropriate mount matrix.
> >   */
> > -static int apply_acpi_orientation(struct iio_dev *indio_dev,
> > -				  struct iio_chan_spec *channels)
> > +static int apply_acpi_orientation(struct iio_dev *indio_dev)
> >  {
> >  	struct st_sensor_data *adata = iio_priv(indio_dev);
> >  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> > @@ -1207,22 +1206,20 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
> >  		}
> >  	}
> >  
> > -	/* Expose the mount matrix via ext_info */
> > -	for (i = 0; i < indio_dev->num_channels; i++)
> > -		channels[i].ext_info = mount_matrix_ext_info;
> > -
> >  	ret = 0;
> >  	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
> >  
> >  out:
> >  	kfree(buffer.pointer);
> > +	dev_warn(&indio_dev->dev,
> > +		 "failed to apply ACPI orientation data: %d\n", ret);
> > +
> 
> As it would be valid to have a new ACPI table that uses a mount_matrix property
> rather than the ONT mess, perhaps we should demote the warnings to debug?
> 
> >  	return ret;
> >  }
> >  #else /* !CONFIG_ACPI */
> > -static int apply_acpi_orientation(struct iio_dev *indio_dev,
> > -				  struct iio_chan_spec *channels)
> > +static int apply_acpi_orientation(struct iio_dev *indio_dev)
> >  {
> > -	return 0;
> > +	return -EINVAL;
> >  }
> >  #endif
> >  
> > @@ -1251,6 +1248,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
> >  	struct iio_chan_spec *channels;
> >  	size_t channels_size;
> >  	int err;
> > +	int i;
> >  
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->info = &accel_info;
> > @@ -1275,9 +1273,28 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
> >  		goto st_accel_power_off;
> >  	}
> >  
> > -	if (apply_acpi_orientation(indio_dev, channels))
> > -		dev_warn(&indio_dev->dev,
> > -			 "failed to apply ACPI orientation data: %d\n", err);
> > +	/* First try ACPI orientation then try the generic function */
> > +	err = apply_acpi_orientation(indio_dev);
> > +	if (err) {
> > +		adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
> > +						   sizeof(*adata->mount_matrix),
> > +						   GFP_KERNEL);
> > +		if (!adata->mount_matrix) {
> > +			err = -ENOMEM;
> > +			goto st_accel_power_off;
> > +		}
> > +
> > +		err = iio_read_mount_matrix(adata->dev, "mount-matrix",
> > +					    adata->mount_matrix);
> > +		if (err)
> > +			goto st_accel_power_off;
> > +	}
> > +	/*
> > +	 * We have at least an identity matrix, so expose the mount
> > +	 * matrix via ext_info
> > +	 */
> > +	for (i = 0; i < indio_dev->num_channels; i++)
> > +		channels[i].ext_info = st_accel_mount_matrix_ext_info;
> 

Fun, I made pretty much the same patch at some point. Mine was really
bad though, since I additionally tried to detect if a mount-matrix is
defined in the device tree. (To keep the existing behavior that the
mount matrix is only exported if != identity. This behavior is
different from all other IIO drivers though so it doesn't make sense...)

I almost sent it a couple of days ago but then I realized that it's bad,
plus what Jonathan just mentioned:

> The current handling of this is odd.  As the comment points out we are providing
> an orientation matrix whatever happens.
> 
> As such I'm fairly sure we can rip out the duplication of the channels and just
> use the static ones, but with ext_info always set.
> 
> Having done that you could also embed the mount_matrix in the private data and
> avoid the need to for a separate allocation.  I guess that might add some small
> overhead to those sensors where orientation doesn't make sense, but I think the
> simplification is probably worth it.
> 

I started implementing this last Tuesday but cannot test it myself
(I don't seem to have any device with a ST accelerometer so I'm still
waiting for some other people to test it). In case you didn't already
implement Jonathan's suggestion, feel free to take the diff below,
modify it further or throw it away if it's bad. :)

If I remember correctly, basically I tried to make the st_accel driver
implement the mount-matrix stuff similar to bmc150-accel-core, which has
similar ACPI code.

Stephan

---

From aa4ea36374c6521674b3e1b6e3e5c4dc5a041081 Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Tue, 11 May 2021 14:45:09 +0200
Subject: [PATCH] iio: accel: st_accel_core: Read mount-matrix from device tree

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/st_accel_core.c     | 129 ++++++++++++--------------
 include/linux/iio/common/st_sensors.h |  14 ++-
 2 files changed, 71 insertions(+), 72 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index dc32ebefe3fc..3607745939e6 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -41,51 +41,74 @@
 #define ST_ACCEL_FS_AVL_200G			200
 #define ST_ACCEL_FS_AVL_400G			400
 
+static const struct iio_mount_matrix *
+get_mount_matrix(const struct iio_dev *indio_dev,
+		 const struct iio_chan_spec *chan)
+{
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return &adata->mount_matrix;
+}
+
+static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
+	{ },
+};
+
 static const struct iio_chan_spec st_accel_8bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 8, 8,
-			ST_ACCEL_DEFAULT_OUT_X_L_ADDR+1),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR+1,
+			mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 8, 8,
-			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR+1),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR+1,
+			mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 8, 8,
-			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR+1),
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR+1,
+			mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_accel_12bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 12, 16,
-			ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR,
+			mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 12, 16,
-			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR,
+			mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 12, 16,
-			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR,
+			mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_accel_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
-			ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR,
+			mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
-			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR,
+			mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
-			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR,
+			mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
@@ -1162,25 +1185,10 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 #endif
 
 #ifdef CONFIG_ACPI
-static const struct iio_mount_matrix *
-get_mount_matrix(const struct iio_dev *indio_dev,
-		 const struct iio_chan_spec *chan)
-{
-	struct st_sensor_data *adata = iio_priv(indio_dev);
-
-	return adata->mount_matrix;
-}
-
-static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
-	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
-	{ },
-};
-
 /* Read ST-specific _ONT orientation data from ACPI and generate an
  * appropriate mount matrix.
  */
-static int apply_acpi_orientation(struct iio_dev *indio_dev,
-				  struct iio_chan_spec *channels)
+static bool apply_acpi_orientation(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -1188,7 +1196,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 	union acpi_object *ont;
 	union acpi_object *elements;
 	acpi_status status;
-	int ret = -EINVAL;
+	bool result = false;
 	unsigned int val;
 	int i, j;
 	int final_ont[3][3] = { { 0 }, };
@@ -1208,16 +1216,16 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 
 	adev = ACPI_COMPANION(adata->dev);
 	if (!adev)
-		return 0;
+		return false;
 
 	/* Read _ONT data, which should be a package of 6 integers. */
 	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
 	if (status == AE_NOT_FOUND) {
-		return 0;
+		return false;
 	} else if (ACPI_FAILURE(status)) {
 		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
 			 status);
-		return status;
+		return false;
 	}
 
 	ont = buffer.pointer;
@@ -1269,14 +1277,6 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 	}
 
 	/* Convert our integer matrix to a string-based iio_mount_matrix */
-	adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
-					   sizeof(*adata->mount_matrix),
-					   GFP_KERNEL);
-	if (!adata->mount_matrix) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	for (i = 0; i < 3; i++) {
 		for (j = 0; j < 3; j++) {
 			int matrix_val = final_ont[i][j];
@@ -1295,26 +1295,23 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 			default:
 				goto out;
 			}
-			adata->mount_matrix->rotation[i * 3 + j] = str_value;
+			adata->mount_matrix.rotation[i * 3 + j] = str_value;
 		}
 	}
 
-	/* Expose the mount matrix via ext_info */
-	for (i = 0; i < indio_dev->num_channels; i++)
-		channels[i].ext_info = mount_matrix_ext_info;
-
-	ret = 0;
+	result = true;
 	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
 
 out:
+	if (!result)
+		dev_warn(&indio_dev->dev, "failed to apply ACPI orientation data\n");
 	kfree(buffer.pointer);
-	return ret;
+	return result;
 }
 #else /* !CONFIG_ACPI */
-static int apply_acpi_orientation(struct iio_dev *indio_dev,
-				  struct iio_chan_spec *channels)
+static bool apply_acpi_orientation(struct iio_dev *indio_dev)
 {
-	return 0;
+	return false;
 }
 #endif
 
@@ -1340,8 +1337,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *pdata = dev_get_platdata(adata->dev);
-	struct iio_chan_spec *channels;
-	size_t channels_size;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1352,20 +1347,16 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 		return err;
 
 	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
+	indio_dev->channels = adata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
-	channels_size = indio_dev->num_channels * sizeof(struct iio_chan_spec);
-	channels = devm_kmemdup(&indio_dev->dev,
-				adata->sensor_settings->ch,
-				channels_size, GFP_KERNEL);
-	if (!channels)
-		return -ENOMEM;
-
-	if (apply_acpi_orientation(indio_dev, channels))
-		dev_warn(&indio_dev->dev,
-			 "failed to apply ACPI orientation data: %d\n", err);
+	if (!apply_acpi_orientation(indio_dev)) {
+		err = iio_read_mount_matrix(&indio_dev->dev, "mount-matrix",
+					    &adata->mount_matrix);
+		if (err)
+			return err;
+	}
 
-	indio_dev->channels = channels;
 	adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 0b9aeb479f48..6a4395ab6636 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/irqreturn.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
@@ -48,8 +49,8 @@
 #define ST_SENSORS_MAX_NAME			17
 #define ST_SENSORS_MAX_4WAI			8
 
-#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
-					ch2, s, endian, rbits, sbits, addr) \
+#define ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod, \
+				    ch2, s, endian, rbits, sbits, addr, ext) \
 { \
 	.type = device_type, \
 	.modified = mod, \
@@ -65,8 +66,14 @@
 		.storagebits = sbits, \
 		.endianness = endian, \
 	}, \
+	.ext_info = ext, \
 }
 
+#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
+				ch2, s, endian, rbits, sbits, addr) \
+	ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod, \
+				    ch2, s, endian, rbits, sbits, addr, NULL)
+
 #define ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL() \
 		IIO_DEV_ATTR_SAMP_FREQ_AVAIL( \
 			st_sensors_sysfs_sampling_frequency_avail)
@@ -215,6 +222,7 @@ struct st_sensor_settings {
  * struct st_sensor_data - ST sensor device status
  * @dev: Pointer to instance of struct device (I2C or SPI).
  * @trig: The trigger in use by the core driver.
+ * @mount_matrix: The mounting matrix of the sensor.
  * @sensor_settings: Pointer to the specific sensor settings in use.
  * @current_fullscale: Maximum range of measure by the sensor.
  * @vdd: Pointer to sensor's Vdd power supply
@@ -234,7 +242,7 @@ struct st_sensor_settings {
 struct st_sensor_data {
 	struct device *dev;
 	struct iio_trigger *trig;
-	struct iio_mount_matrix *mount_matrix;
+	struct iio_mount_matrix mount_matrix;
 	struct st_sensor_settings *sensor_settings;
 	struct st_sensor_fullscale_avl *current_fullscale;
 	struct regulator *vdd;
-- 
2.31.1

