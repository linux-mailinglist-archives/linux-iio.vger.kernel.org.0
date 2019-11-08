Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA0AF416E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfKHHgy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 02:36:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42023 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbfKHHgx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 02:36:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id z12so3650345lfj.9;
        Thu, 07 Nov 2019 23:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m2kDZjBOXCUe76inG6gj5/djhutdp1QdpEld5ceYxnc=;
        b=Xgq+oylaCMdqJkLiXd7wMnkHicLub7VAzT8MPaYqme0OBj9v1SFxCulKY81qAq9xOQ
         tgnUVLFp61NpiTGMAt/B/fnkIeJXBcyZR3+L5ivvfvkCUQC8BoSqGx4jRhZCViOGSd/q
         fDNvVKHmndcrD9W/GmDBIIcTE2OqZIcBnD9SNyRxJe9D+BXKfjYAH5U59jbeKalbymQZ
         OLdqIESyVQXjivDjzE1meP9nRTYF+74zZ3TyQRYdRciXmzltHwmQqsYhcvYVmHQuG7+y
         tv9WG1vaTQ9LLK1ItEmaFHQa25FhzDEB1g7vemJLMLzTOvEQxvgc4sgeQZMK2BYYSw+z
         iXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m2kDZjBOXCUe76inG6gj5/djhutdp1QdpEld5ceYxnc=;
        b=fXzbYRPu6iCnZxCj6Pc8uX31MMJ3zkCaZQAWN/qZWYVU7CoSBj9eufaiJY2Oxwt/M2
         SwYHRIv9TQIXneS5yju+Zfnxzvt/R60KZkHOgmv230qj1aC3uwDstYVn9yVBBEboXcM3
         r2fahsQ8OK42V52m1Dr3ntMAjQKCJaBYm0nm8/mfoHiiDIUsmnnDrvvJ+774dNHc5S9O
         PUAA2MYz4AGEpCUZSstMPdcHs6vk+l6IYSnTMkZPXvqx5o4szrKyhT8MTSZ60dKmmdYe
         4iDksAH5vcs9FsIwRuhQ88hkRZ/oFljHXYpXntgUabgyw1c6zGtImmStB2haTrwO3SWV
         8WUg==
X-Gm-Message-State: APjAAAWlQKtSX7cdb6HjFabU/vA8EcOVuFQRMPWilJI4wOCxgbTA1F7C
        +bETndILrVngVWlzP1mYyIk=
X-Google-Smtp-Source: APXvYqxqg+X0UjsQJGVs11PGvvUYWBjlgE4ZoJVcokBOXar4ksqkJmqb27MWCgF/DjxH44fYMyWFhA==
X-Received: by 2002:ac2:5144:: with SMTP id q4mr5674290lfd.36.1573198611401;
        Thu, 07 Nov 2019 23:36:51 -0800 (PST)
Received: from gmail.com (c-5eea30e8-74736162.cust.telenor.se. [94.234.48.232])
        by smtp.gmail.com with ESMTPSA id a8sm2341564ljf.47.2019.11.07.23.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 23:36:50 -0800 (PST)
Date:   Fri, 8 Nov 2019 08:39:29 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: dac: Migrate LTC1660 documentation
 to yaml
Message-ID: <20191108073929.GA3844@gmail.com>
References: <20191108072539.3547-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108072539.3547-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 08, 2019 at 08:25:39AM +0100, Marcus Folkesson wrote:
> Rewrite bindings to use json-schema vocabulary.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Forgot Robs tag from v2

Reviewed-by: Rob Herring <robh@kernel.org>
