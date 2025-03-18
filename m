Return-Path: <linux-iio+bounces-17022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33859A67523
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 14:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57248178399
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575520CCEB;
	Tue, 18 Mar 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkZ/327W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0862054F2;
	Tue, 18 Mar 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304539; cv=none; b=PPlbauvf9hJ+bedk7YhzF3n1wCZAklDsTPnV2KFL2F+5CcwIXNG4WTn68OrpavITt1n49p1FTvB/EoLKlwiu4lJV7GfEP8+D+LrGhH8noRhGLIN/P9HwELqWvUuY+QL4bndZQVJbeGkse6dniL+7Fz0t553B9vZetCqWke91t1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304539; c=relaxed/simple;
	bh=zkloTWqSwQluyT+su4wyVRo8WPOd3qdFyiz4CAykb8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVE95XoQ60jKIcPS7jn3JS075s724NX+ASGFEEINU/zrT0k6t3vGPLMWZcsB//ch9UdaOq02P8VmbUO8mn7jirAS8NqA7EBBMHA3sxSjT7UCf/pZbb2t/kf73cIgBwlg4J/Rs/C7skBJ5CKfEcS4Nf993kKVxzL5X6mVgdIF2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkZ/327W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BDAC4CEDD;
	Tue, 18 Mar 2025 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742304538;
	bh=zkloTWqSwQluyT+su4wyVRo8WPOd3qdFyiz4CAykb8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pkZ/327WMlXWLGPqy1g2zn1K1X3FoeakUThWo0l65uMdmoESAdlvD1xTki+NDOFrZ
	 gDXBj0fo5WavcaLqPBibqfJ2nKqFDfzq7Jx0kKO2Cc+NRJTzVK5qZbIir+Cw1hH2M2
	 QYOaGiHbyZVSZ9SiXavK4cncCI8FW1IrHKNVjx97keT2Xu8w+TEVSBsAoaFA1DO6A2
	 lNxjbbzTj1nCDCs4IK6x7LZAbL6yiKJ9UyBMDe2htktJO9EOz6+E5MJRlj3D1hOhyM
	 ttHBxBii5PYOh9I9Z6lUMeLLBR1JpiaxZEaIWiPPUh4jNGFIwZEudeu6vgtNu2rlvf
	 WlzUEbFu8Rp1Q==
Message-ID: <c9fb19c4-aa7a-4114-ace4-764d15a2d795@kernel.org>
Date: Tue, 18 Mar 2025 14:28:50 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
To: Sergio Perez Alegre <sergio@pereznus.es>
Cc: tduszyns@gmail.com, jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250316145514.627-1-sergio@pereznus.es>
 <01f48f6d-55a4-4dbe-b1ae-ef8c54dcc1ff@kernel.org>
 <64182937-29e9-45dc-aa2f-5f2b739056a1@me.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <64182937-29e9-45dc-aa2f-5f2b739056a1@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18/03/2025 14:16, Sergio Perez Alegre wrote:
> El 17 mar. 2025, a las 8:24, Krzysztof Kozlowski <krzk@kernel.org> escr=
ibieron: On 16/03/2025 15:55, Sergio Perez wrote: Some BH1750 sensors req=
uire a hardware reset before they can be detected on the I2C bus. This pa=
tch adds support for an optional reset GPIO that can be specified in the =
device tree. The reset sequence pulls the GPIO low and then high before i=
nitializing the sensor, which enables proper detection with tools like i2=
cdetect. Update the devicetree binding documentation to include the new r=
eset-gpios property with examples. Signed-off-by: Sergio Perez <sergio@pe=
reznus.es> Please run scripts/checkpatch.pl and fix reported warnings. Af=
ter that, run also `scripts/checkpatch.pl --strict` and (probably) fix mo=
re warnings. Some warnings can be ignored, especially from --strict run, =
but the code here looks like it needs a fix. Feel free to get in touch if=
 the warning is not clear. <form letter> Please use scripts/get_maintaine=
rs.pl to get a list of necessary people and lists to CC. It might happen,=
 that command when run on an older kernel, gives you outdated entries. Th=
erefore please be sure you base your patches on recent Linux kernel. Tool=
s like b4 or scripts/get_maintainer.pl provide you proper list of people,=
 so fix your workflow. Tools might also fail if you work on some ancient =
tree (don't, instead use mainline) or work on fork of kernel (don't, inst=
ead use mainline). Just use b4 and everything should be fine, although re=
member about `b4 prep --auto-to-cc` if you added new patches to the patch=
set. You missed at least devicetree list (maybe more), so this won't be t=
ested by automated tooling. Performing review on untested code might be a=
 waste of time. Please kindly resend and include all necessary To/Cc entr=
ies. </form letter> Sorry, I had run the scripts/get_maintainer.pl tool a=
nd got fewer recipients than necessary. I have redone everything in a cle=
an installation and now I have obtained more recipients. Any fixes I make=
 in the patch I send to this same thread or should I send it with git sen=
d-mail? I say this because perhaps I have done it incorrectly and possibl=
y created 3 versions, I apologize. My latest version (v3) includes all th=
e suggestions mentioned but due to my ignorance of the procedure I though=
t they should be sent to the list again as before. --- .../devicetree/bin=
dings/iio/light/bh1750.yaml | 20 +++- drivers/iio/light/bh1750.c | 113 ++=
++++++++++------ ... and please go through your patch and see what happen=
ed there. 2 files changed, 95 insertions(+), 38 deletions(-) diff --git a=
/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/=
devicetree/bindings/iio/light/bh1750.yaml index 1a88b3c253d5..d53b221eb84=
b 100644 --- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml ++=
+ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml @@ -11,6 +11,=
9 @@ maintainers: description: | Ambient light sensor with an i2c interfa=
ce. + + Some BH1750 sensors require a hardware reset before being properl=
y detected + on the I2C bus. This can be done using the optional reset-gp=
ios property. properties: compatible: @@ -23,6 +26,10 @@ properties: reg:=
 maxItems: 1 + + reset-gpios: + description: GPIO connected to the sensor=
's reset line (active low) + maxItems: 1 required: - compatible @@ -41,5 =
+48,16 @@ examples: reg =3D <0x23>; }; }; + - | + i2c { + #address-cells =
=3D <1>; + #size-cells =3D <0>; + + light-sensor@23 { + compatible =3D "r=
ohm,bh1750"; + reg =3D <0x23>; + reset-gpios =3D <&gpio2 17 GPIO_ACTIVE_H=
IGH>; + }; + }; -... +... \ No newline at end of file You have unrelated =
changed all over the place. Best regards, Krzysztof


Hm? No clue what this means, sorry, unreadable.

Best regards,
Krzysztof

