Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264AC1CFA37
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 18:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgELQM1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 12:12:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36918 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgELQM0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 12:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589299945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uX9QSrsP6SNGoecHj2+wNvMeZvXQ9loaQHcLwtT0KSI=;
        b=GWQaBfKYEpImd578QR5QH7Xx1a9RSu+W87UOTvS1MW+6LCk3Os0w2dYg5EWPenTc+NFoS0
        DH3/PX+mBdXOauemoNts3nkd/jk0DOvPXuxqQKveuOpACj8+b/HaywF79vcP5yMcw07tEj
        v4D2eCar0gfYkKGLObeLNieRBzPZvrI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-HfnUPVYVPPO_PfuEi3fYvQ-1; Tue, 12 May 2020 12:12:16 -0400
X-MC-Unique: HfnUPVYVPPO_PfuEi3fYvQ-1
Received: by mail-wr1-f69.google.com with SMTP id j16so7131290wrw.20
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 09:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uX9QSrsP6SNGoecHj2+wNvMeZvXQ9loaQHcLwtT0KSI=;
        b=azuW3xX2q/2qc89slPw0GddPTzUxbPK8C0zMBdL05Eg2TxxSUkjuZPjwgI23WTO3lv
         /64bzAm8z/OosloTCpd8z5pWN3yFqaidJKftM8vaV02z6BAxbF+Lh4POSjLUFEkwDMlW
         +wimzzw4s/A4H3F4jRu3WjdeBA258alfLvqAblLOvk0QCu2c+fNbynROZX2ZNQflGEc+
         6rN53cNA+FgZ7CX2fBaeEP5QOzZIxL1WiN1SA3UgQKJXN3l8OoYfXebHQYx5UASBtyZf
         EiB5RbLmJsLRy/8lOt3Ux5kAx7PUvDkVLgOV8KRA3cXi5G5uUlU+seWUtrmSFSU0uum6
         EZCg==
X-Gm-Message-State: AGi0PuY4vxaBLJlSRwIuMFtv+usxE3ZeEcZrcW+Wiee00NAqlq4z60DQ
        IXs8ZDOH3Y8Urx+LQx1owmEmYaQSocp8Mti2OEOPdCJCzdpnamAQrVYbvo03P5lRLr8wV3D2zzn
        1W833Yii5EKsrD9b37x0l
X-Received: by 2002:a5d:6705:: with SMTP id o5mr26609518wru.426.1589299934885;
        Tue, 12 May 2020 09:12:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypINmuOcgnkxWK2SR2cw4GR9aPlPVSuCgb5S27bmnibPcHn5OsS0s10/FyI4AvdddR+yZTwCKg==
X-Received: by 2002:a5d:6705:: with SMTP id o5mr26609504wru.426.1589299934689;
        Tue, 12 May 2020 09:12:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id s8sm22767395wrt.69.2020.05.12.09.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 09:12:14 -0700 (PDT)
Subject: Re: linux-iio and Windows default orientations
To:     Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org
References: <16f4bfe1c254798291507aca00afeb2c8b0978a7.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fad058f5-ba5c-0cf2-317f-c0bb8457846e@redhat.com>
Date:   Tue, 12 May 2020 18:12:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <16f4bfe1c254798291507aca00afeb2c8b0978a7.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/12/20 3:55 PM, Bastien Nocera wrote:
> Hey,
> 
> I'm just dotting the is, and crossing the ts on a bunch of iio-sensor-
> proxy documentation and wanted to revisit the IIO documentation,
> compared to what Windows, and my implementation did.
> 
> Does this:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n1638
> in particular the "Z" axis:
> "Z is perpendicular to the screen plane and positive out of the screen"
> 
> match this:
> https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/sensor-orientation
> "with the positive z-axis extending out from the device."

Yes I believe that the 2 are stating the same, this is also how the
Z axis works on Android I believe. If you put a phone or tablet
flat on a table with the display up, then you will get a -1.0G or -9.8 m/s²
reading since the gravity is pulling downwards (away from the front of
the screen) with 1G.

> This Microsoft page didn't exist when I changed the code to "match
> Windows 10" in 2016:
> https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/commit/35b6328cbdaa5efa30917c445962d64fd733fb02
> 
> (And just to double check, it seems that the other 2 axis do match in
> their definitions, right?)

Yes I believe they do, and also again Android's definition.

Regards,

Hans

