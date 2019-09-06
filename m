Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A0ABDC9
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbfIFQeE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 12:34:04 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:35863 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfIFQeE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Sep 2019 12:34:04 -0400
Received: by mail-io1-f43.google.com with SMTP id b136so14136846iof.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2019 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=M7M0YtDJtolyjmNX0i1VCSVgrRsfZq7AX2O+rmmHnzg=;
        b=s61UUkbrOG10zSpB0yOWftLxbgEMv8B/cKoxyB4RTRCcTJWJ6yCF3mQ42FDc18BjGV
         jSiQDjlumAb4/KBXceOPYBsL6ozdn9ooAww8TAOnnJ5l7wfHLva21rSrNCMXQq8wH88M
         E+5J/e2X6IKlS/6CDWLME8Rkf5bU8sne5OZMNfmn/ox3fWyRJQ03BoWaI57eMgXh8m5K
         yfrUtWYEgOW1Be8JX94u+R5YFhFP1u+q9v6CJIRM0D3rg0jVjZNSbRUI1uJPGgh7egsx
         9VRRAIIUjRxDNhgqu34/MAM/u5h3xC6MRqw7E24wzZg1h+/okxwYqDLEYJbOJcFV6je0
         /7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M7M0YtDJtolyjmNX0i1VCSVgrRsfZq7AX2O+rmmHnzg=;
        b=C6WMIxa+8Pn+Xt/v+3XQ8kbZlfaFkYJkyv5C440p0EOmJ7dQyNxuzeZqj63bNOap9P
         OGuCL4p8z+/1XHEQmZTFtpzB0/paP7HU/e9MceW1XtmVzNH8sUot6Zye4I7s01U6k01V
         mSkGaaE3FecFQWN+5TU+mB0DeUzmC8AhkIY/5o2Bkef7uAUgg/ERydaojgpU+JvTpIC7
         iHoew2npqLE6j2Hd/CZdYyC1HwY3wbl/mu6pZu1CVOoqVeXsBUeZdINRQl+YGk8Bxt/v
         IDORKic0T2B851F9WHLE8KSTfJiPixYYRq1XCNAhqJAjLGyB5takRX81Q/oqR15ji6GG
         jqoA==
X-Gm-Message-State: APjAAAWapI9lxpqTOTWl2M1XIxRhYOF2iXSmhyH+9hC3ChPq2K0AWB7/
        ELPupQdI5+dR+kvWvBkBYo76GvRiXcERpqbdgMzVPoXx
X-Google-Smtp-Source: APXvYqy0Wf+BT4wIAX/kAOE4v8wXPR84bKvYDdYrXhgNDPSup64Htw3A4FfYZmvMCdCtPUoXycqkfnwrboXNpyetjqA=
X-Received: by 2002:a6b:e919:: with SMTP id u25mr5381190iof.30.1567787643078;
 Fri, 06 Sep 2019 09:34:03 -0700 (PDT)
MIME-Version: 1.0
From:   rishi gupta <gupt21@gmail.com>
Date:   Fri, 6 Sep 2019 22:03:52 +0530
Message-ID: <CALUj-gsjKkiF8vrzgeWkh9wo-qBuJDW+5eLPqHqdj3v3ngk4UA@mail.gmail.com>
Subject: Custom sysfs entries for persistence, gain & threshold in light sensor
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi experts,

I am writing driver for veml6030 ambient light sensor. Application can
set persistence, gain & threshold which will in turn update registers
in sensor.

In IIO framework there is no standard constant for this.

1) Does using sysfs entries will be fine or there is better alternative.

static IIO_DEVICE_ATTR_WO(gain, 0);
static IIO_DEVICE_ATTR_WO(threshold, 0);
static IIO_DEVICE_ATTR_WO(persistence, 0);
static IIO_CONST_ATTR(persistence_available, "1 2 4 8");
static IIO_CONST_ATTR(gain_available, "0.125 0.25 1 2");

static struct attribute *veml6030_attributes[] = {
&iio_const_attr_gain.dev_attr.attr,
&iio_const_attr_threshold.dev_attr.attr,
&iio_const_attr_persistence.dev_attr.attr,
&iio_const_attr_persistence_available.dev_attr.attr,
NULL
};

2) Can IIO_CHAN_INFO_HARDWAREGAIN can be used for gain instead of
custom sysfs file.

Datasheet: https://www.vishay.com/docs/84366/veml6030.pdf

Regards,
Rishi
