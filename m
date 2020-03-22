Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0F18E712
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 07:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgCVGLK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 02:11:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45240 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVGLJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 02:11:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id j10so5718639pfi.12;
        Sat, 21 Mar 2020 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OlTTwgDJDrxhOFNzpLQTgXtTgLH4e4DZxu3thtRL82o=;
        b=h337aAfEFa9h2tcpJIXUoh+RHQPy44foiVQQyVLR5FcC2ClOiZBE8d1SrnX3yQWwaX
         tgz+qxMiyaj209JhBonSMiwiDsCdTl0lfOcdfuEThU4q+g0Rhh8/myDM0umodKqMve+Z
         nI3gbp7zJKPBmdnCcFDSyPP/GIdv2znD84wIAGS2Xb6QzJXvNZa1VIPs+F9I0i339ZOb
         47NcAJHggaHFjOYwXQqxMW/3l/NYmbRhz+JA6ERCM3sgXb2wg31dlWjaYrzTO7QmWTNj
         r7EIR+1ZeNiAfV2PE8b56AhkM4pwyiRt6VNSJXDg8cri+CdT0Td3kvXJ+YB4zQ+YQ78K
         KTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OlTTwgDJDrxhOFNzpLQTgXtTgLH4e4DZxu3thtRL82o=;
        b=Nh8/nRCZ5Jw95QSiaUPu3E6ZzvkLZBJ1FwVHKZsxy22FpNKZnzsK1rSxm2V9loATCl
         Wvv5clTZXCwb1UtOt3dDfM8HojUxXN9VqHtVuH2svP35oJ+eHWl1XkwM8UR8hWhfAnsG
         720hLxPH4XhP4es3WNoJoYGzzZxMlCaK14AS5C/84dio68naVSWzkpxlaEtSpvQQONB7
         a3CIa+lKfteePhRbyA1eg0i+aZQjW9Q89TiTDvwwg9G/PdwwT1lenu64p/rIF3pdB4fv
         xJOz4FDipCEJXYitpXUz1x/XSzcLlRXe6c5Qe6Rj3fp/4YDxm6vVSSeWXtjbMIaBFxJ3
         meZQ==
X-Gm-Message-State: ANhLgQ3J5uDKBYyYOerSxMjiCaKkMddO6cOl2BmZ0AS+Y26VLFmiLrt9
        WN7fipLPRstY9GLYA8JTpe/FO1y9kEY=
X-Google-Smtp-Source: ADFU+vuF8WchGXRdT82EO59i+tFpChkiMs7Eatqag+5y9JFsUISI+og4W2JlbD2EaS6oGmXyQoP59Q==
X-Received: by 2002:a63:5011:: with SMTP id e17mr16250248pgb.338.1584857466789;
        Sat, 21 Mar 2020 23:11:06 -0700 (PDT)
Received: from SARKAR ([49.207.56.153])
        by smtp.gmail.com with ESMTPSA id w4sm6744586pfc.57.2020.03.21.23.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 23:11:06 -0700 (PDT)
Message-ID: <5e77017a.1c69fb81.dc341.8ab9@mx.google.com>
X-Google-Original-Message-ID: <20200322061102.GA17797@rohitsarkar5398@gmail.com>
Date:   Sun, 22 Mar 2020 11:41:02 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, dragos.bogdan@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: gyro: adis16136: use scnprintf instead of snprintf
References: <5e723666.1c69fb81.3545b.79c3@mx.google.com>
 <20200322002542.GA2826015@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322002542.GA2826015@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 02:25:42AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 18, 2020 at 08:25:22PM +0530, Rohit Sarkar wrote:
> > scnprintf returns the actual number of bytes written into the buffer as
> > opposed to snprintf which returns the number of bytes that would have
> > been written if the buffer was big enough. Using the output of snprintf
> > may lead to difficult to detect bugs.
> 
> Nice. Have you investigate the code?
> 
> > @@ -96,7 +96,7 @@ static ssize_t adis16136_show_serial(struct file *file,
> >  	if (ret)
> >  		return ret;
> >  
> > -	len = snprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
> > +	len = scnprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
> >  		lot3, serial);
> >  
> >  	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> 
> The buffer size is 20, the pattern size I count to 19. Do you think snprintf()
> can fail?
That might be the case, but IMO using scnprintf can be considered as a
best practice. There is no overhead with this change and further if the
pattern is changed by someone in the future they might overlook the
buffersize
Thanks,
Rohit
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
