Return-Path: <linux-iio+bounces-382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55D67F9060
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 00:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318CC2811AA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 23:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C76315BD;
	Sat, 25 Nov 2023 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=p.jungkamp@gmx.net header.b="WRaSL56m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21014127;
	Sat, 25 Nov 2023 15:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1700956297; x=1701561097; i=p.jungkamp@gmx.net;
	bh=mi7QRaCs5iBY7O6PT5gZCyK68V6tg6DzCWv18RXo6TU=;
	h=X-UI-Sender-Class:Subject:From:Cc:Date;
	b=WRaSL56m/zSabZ9La/qORpRqgs0n1XswDfO9DIbOUtpvC4Ksn63RjT4Ic8+2GP5C
	 4jtDFjMVltFi3g0HHGfM2wYh7tubuZmvmptBgI4f5UkZV43RkTAHOsXhdPQHp+Kh3
	 L9zfWWnXL4kAmc3o92yK8qMuSyVL2dE6dEH0rgo1GzVY8wJsl1ugPZ2Z74SRmyuE1
	 4Frp/L0soD1IQoWrX0XnqZUeNMXGmNXAMChrMq0QYckAwwCjBAzSOGU4tVBv9Gx2Q
	 BvjHMXkW6TeQF/xV6aPor4upmZn1RV5e5YmZu14GDaeLHwgXhs2hHuy9W4PoFZBTU
	 lQ6izV/wcL96+0TO/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from yoga9.fritz.box ([149.50.181.176]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1qzutv1RaE-00BfDP; Sun, 26
 Nov 2023 00:51:37 +0100
Message-ID: <5ab4a33c8750df642c6030412c292890b52b1ae8.camel@gmx.net>
Subject: Empty Intel ISH HID custom sensor feature attributes on Linux 6.6
From: Philipp Jungkamp <p.jungkamp@gmx.net>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Date: Sun, 26 Nov 2023 00:51:36 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:KgsX/V8H23dr3ox7bQztBWlnPIO3QDaPyZBFHtAJsF1Id7YW4uG
 xB6t7U3KR8PCj2s+hBRW9lAfaid+YDUmVAx+4fm1+cU7Mg6DlngSOO3smyHwv+bcYbSHujg
 7FaMuPLZl78UmfZgmCb5LXbHq+UEZMLscwmKIub3H+Wmy3Q2KQgSTfA6p7iF6+zQfzfk45g
 I+19r0MK6PgGflOv0AQcQ==
UI-OutboundReport: notjunk:1;M01:P0:jZa4VyVDjOw=;9f3fKLF9CP3NXXlMJngO+34M50O
 3s89nJpb2jlPydHf9AOBLwzrhJdMjqGaYDQ7RaVqUISCPG/0INJByHgP2U3kaaaqZQEqJEoMe
 6nxB7p6S+LJsZfk/WfSQVuLZ08ZC7GkI+x6AMet7cEyzgDUZwTsak9JvdxVICkjP+Q3c4FlQq
 SFozVfPpg3+XVY5e14W8QCJ1wxIuRGV85kktZbyv6WjepLZe/sXDFYkNtLr7pg3u1mqTmJu4j
 Sk90DWVl9I+rKFmWlV6MkyUTfYKonX3i4z6RFqigFEuIQkUsH75+4H0Z4tbIyLQy7y+YifONn
 h1aNPRX/OtOzPr6gaplFCTHwsFvj7XUA5zWuQVK6YV9CWBhNcTHTyOynUWqLnV7l1QuEoz2DS
 u8BcDN71UcY+OPUZqNMSPgM3PufnB5tkAzncM+03KtP8AvJP+GZ/nrf/O/N//d6xdOSRNzwGg
 4Bva8GxIZ4kW/aWmslABEaVuT/935GJ4KYoqfxL//hz7mCTqAb23igWBwmF287sWEZL9cSAKD
 FGCtL2xldW8AL9rodSGYNx4RBOAVhZ8DEkpVHM/vCzXQsBoddQV7aqVXczgxiBOFlAlpgyv9t
 Pgnc63vUwqeMFta9lKJ6FAx3LVBEFuDj34aUfzd2rpa9trce4sJuAfgc8RMfMSRfMGb/SO6Lq
 7HAqagNub3uqEkfql1st90IO1z1UWTU7ocnImf30LULp/ye1i+g8G5NPILGrl+FlpWM6Pmo05
 Zw7l4nhZi/OM4dkU4h9O/9WsDuXoQekeOqhzQaXaF/mYjY7jfHKk4HhLEOTAzaYYrHJOvJSIP
 O1AOZaIHtl2uXtXqYBR5oJBWREsOeRZWYc7uQrRFOUSeUUdRohl8ow9D4c8TFpWPAOsw+Uu9H
 +uzd14yLlN96oNGX4kTMqyWXUsLMITo5qGdML3BCup+Qei0hug0sfjT2jJGmx0ktRMb5aslhW
 FgZvbQ==
X-Spam-Level: *

Hello,

it seems like the query of custom sensor feature information is not
working in for kernels in the 6.6 series. I've been using a simple
shell script to see what custom sensors are present on my system.

This is now failing to output any information. All bytes in the
feature-*-value file of an HID-SENSOR-2000e1.* sensor in the sysfs are
filled with zeroes. It seems like the underlying call to
hid_sensor_hub_get_feature does only write zeroes into the given
buffer.

The hid-sensor-custom logic that checks for the presence of my ambient
light sensor using that logic is also not working, the HID-SENSOR-LISS-
* device is not showing up. The hid-sensor-hub in question is the Intel
ISH of my Lenovo Yoga 9 14IAP7.

Is this a known problem with the 6.6 series?
Where there related changes in the modules in the stack? E.g.:
- hid-sensor-custom
- hid-sensor-hub
- ishtp-hid

I've not found anything immediatly obvious while checking the git logs.
I'll try to bisect the issue between 6.5 and 6.6 and report back.

Regards,
Philipp Jungkamp



This is the fish script to parse the sysfs feature attributes:

  set -a properties property-friendly-name:'Friendly Name'
  set -a properties property-sensor-model:'Sensor Model'
  set -a properties property-sensor-manufacturer:'Manufacturer'
  set -a properties property-sensor-serial-number:'Serial Number'

  function get_value -a file
    set_color blue
    for letter in (string split -n ' ' < $file)
      test ! $letter -eq 0
      and printf \\(printf %o $letter)
    end
    set_color normal
  end

  function check_property -a property feature
    if string match -q (string split -f1 ':' $property) -- (cat
feature/*-name)
      echo \t(string split -f2 ':' $property): (get_value $feature/*-
value)
    end
  end

  for sensor in /sys/bus/hid/devices/*/HID-SENSOR-2000e1*
    echo Sensor: (set_color green; realpath $sensor; set_color normal)
    for feature in $sensor/feature-*
      for property in $properties
        check_property $property $feature
      end
    end
    echo
  end


Example output from Linux 6.5:

  Sensor: /sys/devices/pci0000:00/0000:00:12.0/{33AECD58-B679-4E54-
9BD9-A04D34F0C226}/001F:8087:0AC2.0003/HID-SENSOR-2000e1.7.auto=20
	Serial Number: LUID:00E1001A270E0080
	Sensor Model: LENOVO_ST_HUMANSENSE S
	Manufacturer: LENOVO
	Friendly Name: Lenovo ST HPD v201 Sensor


Example output from Linux 6.6:

  Sensor: /sys/devices/pci0000:00/0000:00:12.0/{33AECD58-B679-4E54-
9BD9-A04D34F0C226}/001F:8087:0AC2.0003/HID-SENSOR-2000e1.7.auto=20
	Serial Number:=20
	Sensor Model:
	Manufacturer:
	Friendly Name:



