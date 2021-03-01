Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13926327580
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 01:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhCAAMY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 19:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhCAAMX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 19:12:23 -0500
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Feb 2021 16:11:43 PST
Received: from chill.innovation.ch (unknown [IPv6:2600:1f13:715:900:847:f6f4:e557:d77c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACA2C06174A
        for <linux-iio@vger.kernel.org>; Sun, 28 Feb 2021 16:11:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id EBF7B1B5ACE;
        Mon,  1 Mar 2021 00:04:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at innovation.ch
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0jlRjtn27m3V; Mon,  1 Mar 2021 00:04:30 +0000 (UTC)
Date:   Mon, 1 Mar 2021 00:04:30 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 chill.innovation.ch 78F081B6455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1614557070;
        bh=mbPn0neLZcgRJejMJaMjct0DkzF3tnCRvFCGemkflVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVhY98tLOyzCz4G0i3Co0sjUrs1QLKzRChFXwi9co8ncAXusTmGS5xLttk78YAQFu
         6jLSG3c9sYC5CgICV4ixEQ14/xnUOgHeT8MDDKNaaRsXnR4vpdTkSTnJH2CtF7gNNR
         2G1BQM55j02tCgATdepgTYAoosJYfsxoi0Ft26BTvwKtQDKtepIvuhs4h8Yzb6qbyE
         P2BnivEJv+wJr8BOa5mtFVgRlOLwSnL/OsAFLNH5fbmOuy/a9tAz7v+yd4hDrl76+N
         P4+sWPiDRPiaEgZEOLlW6RVbQO9YLhYZfLvUPAGL/xkstRfHJujMcAxaQmkxEFMxVY
         bKP+T1WAtC/Rw==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Message-ID: <20210301000430.GA754582@innovation.ch>
References: <20210228012643.69944-1-ronald@innovation.ch>
 <20210228012643.69944-5-ronald@innovation.ch>
 <20210228150239.00007d34@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210228150239.00007d34@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


  Hi Jonathan,

On Sun, Feb 28, 2021 at 03:02:39PM +0000, Jonathan Cameron wrote:
> On Sat, 27 Feb 2021 17:26:42 -0800
> Ronald Tschal?r <ronald@innovation.ch> wrote:
[snip]
> > +#ifdef CONFIG_PM
> > +/**
> > + * appleib_forward_int_op() - Forward a hid-driver callback to all drivers on
> > + * all virtual HID devices attached to the given real HID device.
> > + * @hdev the real hid-device
> > + * @forward a function that calls the callback on the given driver
> > + * @args arguments for the forward function
> > + *
> > + * This is for callbacks that return a status as an int.
> > + *
> > + * Returns: 0 on success, or the first error returned by the @forward function.
> > + */
> > +static int appleib_forward_int_op(struct hid_device *hdev,
> > +				  int (*forward)(struct hid_driver *,
> > +						 struct hid_device *, void *),
> > +				  void *args)
> > +{
> > +	struct appleib_hid_dev_info *hdev_info = hid_get_drvdata(hdev);
> > +	struct hid_device *sub_hdev;
> > +	int rc = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(hdev_info->sub_hdevs); i++) {
> > +		sub_hdev = hdev_info->sub_hdevs[i];
> > +		if (sub_hdev->driver) {
> > +			rc = forward(sub_hdev->driver, sub_hdev, args);
> > +			if (rc)
> > +				break;
> 
> return rc; here would be cleaner.
> 
> > +		}
> > +
> > +		break;
> 
> This is unusual.  It's a for loop but as far as I can see only first iteration
> can ever run as we exit the loop at this break if we haven't done so earlier.
> What is the intent here?
> 
> > +	}
> > +
> > +	return rc;
> > +}

Ho boy, good catch! This is simply a mistake. As you say, it should
(and does now) read:

	for (i = 0; i < ARRAY_SIZE(hdev_info->sub_hdevs); i++) {
		sub_hdev = hdev_info->sub_hdevs[i];
		if (sub_hdev->driver) {
			rc = forward(sub_hdev->driver, sub_hdev, args);
			if (rc)
				return rc;
		}
	}

	return rc;

Thanks.


  Cheers,

  Ronald

