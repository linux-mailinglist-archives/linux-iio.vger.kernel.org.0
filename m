Return-Path: <linux-iio+bounces-8268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AEA948C6E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 11:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520071F25846
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF86E1BDAAD;
	Tue,  6 Aug 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIgKtVHa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9AF4FA;
	Tue,  6 Aug 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937997; cv=none; b=ZdhJEq4NjQ3+CuLtLsr63mU8O5/bFhtzz4bP0AWB4hG+c4x60vpm7fEBMcBHTU2p9P3F8SJhLpkUAnmy6Afg3tsLbwYRG3PaS6qrTUTNbZQz2dQELe0lWpw0E9RPT8B62GfSikhqEt6g4DcwAgD0o49RCorJ9Ym8yC2mmFjNh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937997; c=relaxed/simple;
	bh=YlrGk0eWcSMeOxrP+q9m2CXmPxYl8BQMUsHGzZUmaCE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NPu16bWeuvZcx5NlaegmSOz8F+orLuOOR3ePkn4uImWPtwN+rK81ZyP3Wpo+3cCeHCxrMjvM5JFANj6Iduu9XOldWK2uBUXEmfSHkoQYXt+eb0GU9bfMTHsQCkNw4wjVmnYj4gsgyUp6wHDgP3jh8n/dQ9jF5B/491e8hCzhBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIgKtVHa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428119da952so3126015e9.0;
        Tue, 06 Aug 2024 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722937994; x=1723542794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mQPS9zg7TGIvwm6agg96nJdEWh3XQlPRFsLMFHgNQs=;
        b=WIgKtVHagampGi6/jFZ7iPfeCMwzVVC/oEpZH7EUhYEOe9TWqwfvv8R5e+OFKZ2msq
         eFNykmf45EBRH+BIjxVjKONOATKasYnQ3PD2EmPxOU/0d9G5qD2QIR0I8zydwShvOErI
         Qu4z3CeVYwa6euOfwRFV1M73IXKlXqhEkP6HPHlfFwL134ouAZME4OhEKid2I8RsKMxa
         rTF+BSex0iZMBJSzaEFkzF2wOJ62ATymFE8PKXKHvtW9uEKFjOcz4VgDf2MVteqzrCuH
         Itx/1ilgnN7vnWfmTr1Tp8dIzE+eAkoAawAXKIj20ZeH8D30htIKSjO6EDBEPCTrvD1v
         aGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722937994; x=1723542794;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2mQPS9zg7TGIvwm6agg96nJdEWh3XQlPRFsLMFHgNQs=;
        b=l3pnTHAIJh4W4x+2MwojE3KOWP1eNxnyGCyvChqScwenmqom2kkrnjTGcuN6ywaSIe
         3683Eh0hK4i0Ki+IS8oSTTyRHS2X16oTGx9zVtlC0jw1JSwWKGEsu2YYvOrF3HsY1dO4
         +sdVtK3aVZPqyeq7m+aDbghahJu+WkBHP2FKI9uys8he6W+V7m/f2KF1ykZ0oSzbT9nb
         zTFtqIWegCQIa6qkf8t7hXm5WtbTP4lUgwM0mZbS7Gv4cIoPirxt+1YhtdcZ7me4LoPK
         hajLoU3KjPhzLIhmQ7lOgJ+CteJwcv/ahvDyRBFtxFuPv6CVBefHEyfYTk8DKW4mWD2l
         jUgw==
X-Forwarded-Encrypted: i=1; AJvYcCXuqlh6PUSZzDyPvALlan5N+9/9LvWw0jfsv4Nxo7z0vsDWs07AW2M4+uc45EOxfHcJE2x0bnfrtDsIlLwqY9h1V18dnQKza8NywlPRQkitf4b4aeJ8YYzfT/wi2/hEJ2GBJZNrZMDjA31Vr8gc6n1jvGv+I7OFy7OkvaUmgQIo9FL7pg==
X-Gm-Message-State: AOJu0YzmpG6npVEHXuhvgHLzNVX30zSDxcVcpHaiyeN5U+Qvh7ns5t3L
	gyYRONgb07GoIfQUCZOGHsbBOfy6iJyDveQV3vsAc9K0ZUhJouMTCTslL5oq
X-Google-Smtp-Source: AGHT+IHxn9Y5AXE0NxP2JtVmiQmgpmFT4+fYLO9J518Mr77PSMlwGH9nzHumSAjUEHlc/hxhWdqPrQ==
X-Received: by 2002:a05:600c:19cb:b0:426:64f4:7793 with SMTP id 5b1f17b1804b1-428e6b30a06mr108861175e9.22.1722937993580;
        Tue, 06 Aug 2024 02:53:13 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9cd4esm172094365e9.44.2024.08.06.02.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:53:13 -0700 (PDT)
Date: Tue, 06 Aug 2024 11:53:12 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <66b1f288678b6_31cc370bc@njaxe.notmuch>
In-Reply-To: <20240729211100.0d602d6e@jic23-huawei>
References: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
 <20240724-iio-pac1921-v4-3-723698e903a3@gmail.com>
 <20240728135306.422713ea@jic23-huawei>
 <66a784bac1db7_89a37017@njaxe.notmuch>
 <20240729211100.0d602d6e@jic23-huawei>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
> > > > +
> > > > +/*
> > > > + * Emit on sysfs the list of available scales contained in scales_tbl
> > > > + *
> > > > + * TODO:: this function can be replaced with iio_format_avail_list() if the
> > > > + * latter will ever be exported.  
> > > 
> > > You could just have added a precursor patch doing that.
> > > If you have time I'd certainly consider a patch that does export that function
> > > and uses it here.
> > >  
> > I wasn't sure that one usage was enough to justify the export. I could
> > definitely do it, I am assuming it would now go to a new patch series since
> > this has already been merged into testing, right?
> The requirements for justifying exporting an existing function is less
> than it would be to add a new one.  As such I think it makes sense.
> 
> As you note, needs a separate patch on top of the tree.
> 
I will try to address this more generally by adding a new
read_avail_release_resource() iio_info function, see below. If that goes
through, exporting the iio_format_avail_list() would not be necessary since the
driver could directly use the read_avail iio_info function.

> > 
> > > > + *
> > > > + * Must be called with lock held if the scales_tbl can change runtime (e.g. for
> > > > + * the current scales table)
> > > > + */
> > > > +static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
> > > > +					  size_t size, char *buf)
> > > > +{
> > > > +	ssize_t len = 0;
> > > > +
> > > > +	for (unsigned int i = 0; i < size; i++) {
> > > > +		if (i != 0) {
> > > > +			len += sysfs_emit_at(buf, len, " ");
> > > > +			if (len >= PAGE_SIZE)
> > > > +				return -EFBIG;
> > > > +		}
> > > > +		len += sysfs_emit_at(buf, len, "%d.%09d", scales_tbl[i][0],
> > > > +				     scales_tbl[i][1]);
> > > > +		if (len >= PAGE_SIZE)
> > > > +			return -EFBIG;
> > > > +	}
> > > > +
> > > > +	len += sysfs_emit_at(buf, len, "\n");
> > > > +	return len;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Read available scales for a specific channel
> > > > + *
> > > > + * NOTE: using extended info insted of iio.read_avail() because access to
> > > > + * current scales must be locked as they depend on shunt resistor which may
> > > > + * change runtime. Caller of iio.read_avail() would access the table unlocked
> > > > + * instead.  
> > > 
> > > That's a corner case we should think about closing. Would require an indicator
> > > to read_avail that the buffer it has been passed is a snapshot that it should
> > > free on completion of the string building.  I don't like passing ownership
> > > of data around like that, but it is fiddly to do anything else given
> > > any simple double buffering is subject to race conditions.
> > >  
> > If I understand your suggestion the driver would allocate a new table and copy
> > the values into it at each read_avail() call. Then
> > iio_read_channel_info_avail() would free the buffer if some sort of
> > free-after-use indicator flag is set. I guess such indicator might be set via an
> > additional read_avail function argument (would be an extensive API change) or
> > maybe via a new iio_chan_spec attribute.
> 
> Probably needs to be in read_avail() as otherwise we end up with yet more masks.
> However, doesn't need to be global.  read_avail_ext() could be added that
> is used in preference to read_avail() if it is supplied.  That new one can
> be used only be drivers that need to handle the allocation and free.
> However I prefer the explicit resource free option as we can in theory
> at least do much cleverer things than simply freeing the buffer.
> 
> > 
> > > An alternative would use a key of sometype to associate individual read_avail
> > > calls with new ones to read_avail_release_resource. That might be cleaner.
> > >   
> > Are you referring to introduce a new read_avail_realease_resource callback that
> > would be called at the end of iio_read_channel_info_avail() if set? Similarly
> > to the previous point the driver would allocate a new table and copy the values
> > into it at each read_avail() call, but the driver would also define a release
> > callback to free such table. If otherwise you are referring to something less
> > trivial, is there a similar API in the kernel that can be referred to for
> > clarity?
> 
> Indeed what you suggest. Key is it puts the burden on the driver to do it's
> own management. That avoids handing ownership of the buffer to the core
> which is a pattern I'm not that keen on if we can avoid it.
> 
> The new callback would take the buffer pointer that came back from read_avail()
> and pass that back to the driver.  In simple case the driver could just
> free the buffer.  However, it could also do some cleverer stuff to keep
> it around if a write hasn't raced with this code.  That might make sense if
> it's a big table and calculating the values is expensive.
>
I am trying to achieve this and it looks pretty straightforward for the case we
considered, iio would be extended like the following:

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e6fad8a6a1fc..fe6ad8e9722f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -860,12 +860,20 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
                return ret;
        switch (ret) {
        case IIO_AVAIL_LIST:
-               return iio_format_avail_list(buf, vals, type, length);
+               ret = iio_format_avail_list(buf, vals, type, length);
+               break;
        case IIO_AVAIL_RANGE:
-               return iio_format_avail_range(buf, vals, type);
+               ret = iio_format_avail_range(buf, vals, type);
+               break;
        default:
-               return -EINVAL;
+               ret = -EINVAL;
        }
+
+       if (indio_dev->info->read_avail_release_resource)
+               indio_dev->info->read_avail_release_resource(
+                       indio_dev, this_attr->c, vals, this_attr->address);
+
+       return ret;
 }

 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f6c0499853bb..0ab08b94bad0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -491,6 +491,10 @@ struct iio_info {
                          int *length,
                          long mask);

+       void (*read_avail_release_resource)(struct iio_dev *indio_dev,
+                                           struct iio_chan_spec const *chan,
+                                           const int *vals, long mask);
+
        int (*write_raw)(struct iio_dev *indio_dev,
                         struct iio_chan_spec const *chan,
                         int val, 

And with the following usage example for the pac1921 driver:

static int pac1921_read_avail(struct iio_dev *indio_dev,
			      struct iio_chan_spec const *chan,
			      const int **vals, int *type, int *length,
			      long mask)
{
	switch (mask) {
	//...
	case IIO_CHAN_INFO_SCALE:
		switch (chan->channel) {
		//...
		case PAC1921_CHAN_CURRENT: {
			struct pac1921_priv *priv = iio_priv(indio_dev);
			size_t len;
			int *buf;

			len = ARRAY_SIZE(priv->current_scales) * 2;
			buf = kmalloc_array(len, sizeof(int), GFP_KERNEL);
			if (!buf)
				return -ENOMEM;

			for (unsigned int i = 0; i < len; i++)
				buf[i] = ((int *)priv->current_scales)[i];

			*vals = buf;
			*length = (int)len;
			*type = IIO_VAL_INT_PLUS_NANO;
			return IIO_AVAIL_LIST;
		}
		default:
			return -EINVAL;
		}
	default:
		return -EINVAL;
	}
}

static void pac1921_read_avail_release_res(struct iio_dev *indio_dev,
					   struct iio_chan_spec const *chan,
					   const int *vals, long mask)
{
	if (mask == IIO_CHAN_INFO_SCALE &&
	    chan->channel == PAC1921_CHAN_CURRENT)
		kfree(vals);
}

static const struct iio_info pac1921_iio = {
	//...
	.read_avail = pac1921_read_avail,
	.read_avail_release_resource = pac1921_read_avail_release_res,
};

However I noticed that some consumer drivers also expose the producer's
available lists through the following functions:
- iio_read_avail_channel_attribute()
- iio_read_avail_channel_raw()
- iio_channel_read_max()
- iio_channel_read_min()

While addressing the read_max()/read_min() is trivial since the
release_resource() can be called at the end of those function, I think the
first twos should be tracked as well for later release by the consumer drivers.
So for example the consumer driver would also expose a
iio_read_avail_channel_attribute_release_resource() (any suggestion for shorter
function names?) mapped to the read_avail_release_resource() iio_info function.
However the fact that iio_read_avail_channel_attribute() locks on
info_exist_lock, makes me think that the driver could be unregistered between a
read_avail() and a read_avail_release_resource() and in that case an allocated
list would be leaked, right? Any suggestion on how best handle this case? My
guess is to let iio destroy the list at some point during device release, that
would be done if the list allocation was done through devm_kmalloc (or similar)
but I think it would result in double frees during usual case, so maybe there
should be a way to let it free the list only if not already freed? Or maybe a
complete different approach?

> > 
> > > oh well, a cleanup job for another day.   I suspect we have drivers today
> > > that are subject to tearing of their available lists.
> > >   
> > I've just taken a quick look at the other drivers and the following twos seem
> > to have the race condition issue since they are updating an available table
> > during a write_raw() call and also exposing it during a read_avail() call:
> > * drivers/iio/light/as73211.c: see int_time_avail table
> > * drivers/iio/adc/ad7192.c: see filter_freq_avail table
> > 
> > There might be others, I've only looked into those that seemed likely to have
> > this issue after some trivial greps.
> > 
> > Is there already a common way for iio to keep track of open issues (e.g. Issue
> > tracker/TODO lists/etc)?
> 
> Not really.  Email to the list tends to be the most we do for tracking.
> I have had various todo lists public over the years, but they tend to rot.
> 
> Fix stuff before we forget about it! :(
> 
I could try to provide fix patches for those two drivers as well, but I could
not test them on the real HW. I am wondering whether to add them to the same
release_resource() patch series or into a separate series since those fixes
could be sit for a while waiting for additional tests.

Thanks,
Matteo Martelli

